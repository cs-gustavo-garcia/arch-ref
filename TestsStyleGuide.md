## Criação
### Separar comportamentos por arquivos
Sempre que houver um `setUp` diferente, um novo arquivo deve ser criado

## Nomenclatura classes de teste
### Criar um grupo com o nome da unit a ser testada

Se a unit a ser testada é por exemplo `Income` deve-se criar um grupo com esse nome

![image](https://user-images.githubusercontent.com/60656628/183557636-7de193d2-2275-4d7a-9b04-67b89bb32a2d.png)

### Nome do arquivo padrão
Padrão: `<nome unit><contexto em teste>TestCase` e deve seguir o padrão `PascalCase`

// Not Preferred

![image](https://user-images.githubusercontent.com/60656628/183559522-b74326cb-22b4-4fec-bf1a-f9ce3257d692.png)

// Preferred

![image](https://user-images.githubusercontent.com/60656628/183559547-87c8a989-7781-43aa-843b-c2664ddb4de1.png)
	
## Nomenclatura função de teste
### Utilizar `camelCase`
```swift
    // Preferred
    func testPressButton() {
        // Test
    }

    // Not Preferred
    func test_Press_button() {
        // Test
    }
```

### Deve ser enxuto
Caso o nome não seja enxuto, sempre sugerir uma mudança para o nome
```swift
    // Preferred
    func testPressButton() {
        // Test
    }

    // Not Preferred
    func testWhenPressButtonShouldSendAction() {
        // Test
    }
```

### Test Doubles e conceitos
Utilizar a nomenclatura de tests doubles corretamente. Referência: [Test Double Swift e isolamento de testes | Concrete](https://medium.com/concretebr/test-doubles-swift-cd43372eb45e)
	

## setUp
### Objetivo do setUp
Deve ser utilizado apenas para configuração do contexto que será testado, por exemplo atribuições de delegates e view models.

### Inicialização e Granularização do SUT
O **sut** deve ser inicializado em sua declaração, com exceção dos casos em que sua inicialização na declaração exigiria uma granularização maior que por contexto.

No exemplo abaixo, a granularização para esse contexto exigiria 4 arquivos com apenas 1 teste.
```swift
// Granularization greater than the context

class FeatureServiceTestCase: XCTestCase {

    override class func setUp() {
        super.setUp()
        Feature.setup(service: FeatureToggleServiceStub(toSucceed: true), persistence: FeatureTogglePersistenceStub())
    }

    func testEmptyKeyValue() {
        let sut = Feature(key: "")
        XCTAssertFalse(sut.wrappedValue)
    }

    func testValidKeyValue() {
        let sut = Feature(key: "valid")
        XCTAssertTrue(sut.wrappedValue)
    }

    func testInvalidKeyValue() {
        let sut = Feature(key: "invalid")
        XCTAssertFalse(sut.wrappedValue)
    }

    func testSomeKeyValue() {
        let sut = Feature(key: "some")
        XCTAssertFalse(sut.wrappedValue)
    }

}
```

No exemplo abaixo, embora um Router tenha diversos casos, cada um deles envolve no mínimo 4 testes.
```swift
class SendDollarBillingRouteTestCase: XCTestCase {

    let sut = SetupRouter.sendDollarBilling(option: "INVOICE")

    func testHTTPMethod() {
        XCTAssertEqual(sut.method, .put)
    }

    func testPath() {
        XCTAssertEqual(sut.path, "/accounts/v1/accounts/0/dollar-billing-option")
    }

    func testParameters() {
        XCTAssertEqual(sut.parameters?.count, 1)
    }

    func testURL() {
        let urlString = try? sut.asURLRequest().url?.absoluteString
        XCTAssertEqual(urlString, "https://test.com/accounts/v1/accounts/0/dollar-billing-option")
    }

}
```

## Assert
### Objetivo do Assert
Deve realizar as asserções.

### Quantidade de asserts
Podem ser criados quantos `asserts` forem necessários.

### Modelos com closure
Para modelos o init pode ser testado com um teste com diversas asserções e caso haja uma closure ela deve ser testada em outro teste.
```swift
class MyViewModelTestCase: XCTestCase {

    lazy var sut = MyViewModel(xpto: true) {
        self.isActionCalled = true
    }
    var isActionCalled = false

    // Preferred
    func testPropertyDefaultValues() {
        XCTAssertTrue(sut.xpto)
    }

    func testAction() {
        sut.action()
        XCTAssertTrue(isActionCalled)
    }

    // Not Preferred
    func testPropertyDefaultValues() {
        XCTAssertTrue(sut.xpto)
        sut.action()
        XCTAssertTrue(isActionCalled)
    }

}
```

### Não utilizar XCTAssert
Não utilizar o `XCTAssert` apenas. Caso precise utilizar, especifique a mensagem.

```swift
    // Preferred
    func testViewType() {
        XCTAssertTrue(sut is MyView)
    }

    // Not Preferred
    func testViewType() {
        XCTAssert(type(of: sut) == MyView.self)
    }
```

## tearDown
### Objetivo do tearDown
Resetar todas as variáveis criadas.

### Boas práticas
Não utilizar force unwrap ou force cast. Utilize o `XCTUnwrap` e caso seu uso seja inviável utilize um `guard let` junto de um `XCTFail` com uma mensagem explicativa caso falhe. 
```swift
// XCTUnwrap Preferred
func testHeader() throws {
    let header = try XCTUnwrap(sut.headerFactory(tableView) as? LateChargesHeaderView)

    XCTAssertNotNil(header.viewModel)
    XCTAssertEqual(sut.headerHeight, UITableView.automaticDimension)
} 

// guard let Preferred
func testHeader() {
    guard let header = sut.headerFactory(tableView) as? LateChargesHeaderView else {
        return XCTFail("Unable to get header view")
    }

    XCTAssertNotNil(header.viewModel)
    XCTAssertEqual(sut.headerHeight, UITableView.automaticDimension)
}

// Not Preferred
func testHeader() {
    let header = sut.headerFactory(tableView) as! LateChargesHeaderView

    XCTAssertNotNil(header.viewModel)
    XCTAssertEqual(sut.headerHeight, UITableView.automaticDimension)
}

```

### tearDown sempre que houver setUp
Sempre que houver um `setUp` - que realiza uma configuração que pode ser desfeita - o arquivo deve ter um `tearDown` para reverter a configuração, usar o bom senso sobre a localização desses métodos.

### Snapshot tests
Os testes de snapshot devem estar em um arquivo de teste apenas para os snapshots
```swift
final class LoginContainerViewSnapshotTestCase: FBSnapshotTestCase {

    var sut = LoginContainerView()

    override func setUp() {
        super.setUp()
        recordMode = false
        sut.frame = CGRect(x: 0, y: 0, width: 288, height: 216)
        sut.viewModel = LoginContainerViewModel(standardTitle: "Button 1", ghostTitle: "Button 2", invisibleTitle: "Button 3")
    }

    override func tearDown() {
        sut.frame = .null
        sut.viewModel = nil
        super.tearDown()
    }

    func testSnapshot() {
        FBSnapshotVerifyView(sut)
    }

}
```

### Device de snapshot
Snapshots devem ser feitos com **iPhone 11 Pro**
