## Criação
### Hierarquia de pastas e arquivos
As pastas e arquivos de testes devem seguir a mesma ordem e hierarquia das pastas de desenvolvimento do projeto.

## Nomenclatura classes de teste
### Criar um grupo com o nome da unit a ser testada

Se a unit a ser testada é por exemplo `Profile` deve-se criar um grupo com esse nome

<img width="450" alt="image" src="https://github.com/cs-gustavo-garcia/arch-ref/assets/60656628/7d5d02ff-9e91-41f8-98da-b9da66fac056">

### Nome do arquivo padrão
Padrão: `<nome unit>TestCase` e deve seguir o padrão `PascalCase`

// Not Preferred

<img width="450" alt="image" src="https://github.com/cs-gustavo-garcia/arch-ref/assets/60656628/847315e7-e609-4a0e-b46e-1470e4d62ab1">

// Preferred

<img width="450" alt="image" src="https://github.com/cs-gustavo-garcia/arch-ref/assets/60656628/361af8af-d738-427c-8a80-66836f264893">

	
## Nomenclatura função de teste
### Utilizar `snake_case` para separar o que esta sendo testado e qual é o resultado esperado.
Padrão: `test_<função ou variável que será testada>_<cenário específico (caso houver)>_<o que é esperado como resultado>`
```swift
    // Preferred
    func test_pressButton_withSwitchOn_shouldPresentProfileScreen() {
        // Test
    }

    func test_pressButton_withSwitchOff_shouldNotPresentProfileScreen() {
        // Test
    }

    // Not Preferred
    func testPressButton() {
        // Test
    }

    func test_PressButton_ShouldPresentProfileScreen() {
        // Test
    }

    func test_PressButtonWithSwitchOn_ShouldPresentProfileScreen() {
        // Test
    }

```

### Test Doubles e conceitos
Utilizar a nomenclatura de tests doubles corretamente. Referência: [Test Double Swift e isolamento de testes | Concrete](https://medium.com/concretebr/test-doubles-swift-cd43372eb45e)
	

## setUp
### Objetivo do setUp
Deve ser utilizado apenas para configuração do contexto que será testado, por exemplo atribuições de delegates e view models.

### Inicialização do SUT
O **sut** e outras variáveis devem ser inicializados em sua declaração, e em seguida na função `setUp`, deve-se atribuir os devidos valores. 

```swift
final class ProfileViewTestCase: XCTestCase {

    var sut: ProfileViewTestCase!
    var profileViewDelegateSpy: ProfileViewDelegateSpy!

    override func setUp() {
        super.setUp()
	profileDelegateSpy = .init()
	sut = .init()
	sut.delegate = profileDelegateSpy
    }

    override func tearDown() {
        profileViewDelegateSpy = nil
	sut = nil
	super.tearDown()
    }

    ...

}
```

No exemplo abaixo, embora um Router tenha utilize o `setUp`, em 1 dos testes é atribuído um novo sut para um teste específico.
```swift
final class ProfileViewTestCase: XCTestCase {

    var sut: ProfileViewTestCase!
    var profileViewDelegateSpy: ProfileViewDelegateSpy!

    override func setUp() {
        super.setUp()
	profileDelegateSpy = .init()
	sut = .init(isSwitchOn: true)
	sut.delegate = profileDelegateSpy
    }

    override func tearDown() {
        profileViewDelegateSpy = nil
	sut = nil
	super.tearDown()
    }

    func test_closeButton_withSwitchOn_shouldDismiss() {
	XCTAssertTrue(sut.xpto)
    }

    func test_confirmButton_shouldSaveProfile() {
	XCTAssertEqual(sut.xpto, "xpto")
    }

    func test_closeButton_withSwitchOff_shouldNotDismiss() {
	sut = .init(isSwitchOn: false)
	XCTAssertFalse(sut.xpto)
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
final class MyViewModelTestCase: XCTestCase {

    var sut: MyViewModel!
    var isActionCalled: Bool!

    override func setUp() {
        super.setUp()
	isActionCalled = false
	sut = .init(xpto: true) {
	    self.isActionCalled = true
	}
    }

    override func tearDown() {
        isActionCalled = nil
	sut = nil
	super.tearDown()
    }

    // Preferred
    func test_xpto_withDefaultValue_shouldBeTrue() {
        XCTAssertTrue(sut.xpto)
    }

    func test_action_shouldCallClosure() {
        sut.action()
        XCTAssertTrue(isActionCalled)
    }

    // Not Preferred
    func test_xpto_withDefaultValue_shouldBeTrue() {
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
    func test_view_shouldBeMyViewType() {
        XCTAssertTrue(sut is MyView)
    }

    // Not Preferred
    func test_view_shouldBeMyViewType() {
        XCTAssert(type(of: sut) == MyView.self)
    }
```

### Boas práticas
Não utilizar force unwrap ou force cast. Utilize o `XCTUnwrap` e caso seu uso seja inviável utilize um `guard let` junto de um `XCTFail` com uma mensagem explicativa caso falhe. 
```swift
// XCTUnwrap Preferred
func test_header_shouldBebuiltCorrectly() throws {
    let header: LateChargesHeaderView = try XCTUnwrap(sut.headerFactory(tableView) as? LateChargesHeaderView)

    XCTAssertNotNil(header.viewModel)
    XCTAssertEqual(sut.headerHeight, UITableView.automaticDimension)
} 

// guard let Preferred
func test_header_shouldBebuiltCorrectly() {
    guard let header: LateChargesHeaderView = sut.headerFactory(tableView) as? LateChargesHeaderView else {
        return XCTFail("Unable to get header view")
    }

    XCTAssertNotNil(header.viewModel)
    XCTAssertEqual(sut.headerHeight, UITableView.automaticDimension)
}

// Not Preferred
func test_header_shouldBebuiltCorrectly() {
    let header: LateChargesHeaderView = sut.headerFactory(tableView) as! LateChargesHeaderView

    XCTAssertNotNil(header.viewModel)
    XCTAssertEqual(sut.headerHeight, UITableView.automaticDimension)
}

```

## tearDown
### Objetivo do tearDown
Resetar todas as variáveis criadas.

### tearDown sempre que houver setUp
Sempre que houver um `setUp` - que realiza uma configuração que pode ser desfeita - o arquivo deve ter um `tearDown` para reverter a configuração, usar o bom senso sobre a localização desses métodos.

```swift
final class ProfileViewTestCase: XCTestCase {

    var sut: ProfileViewTestCase!
    var profileViewDelegateSpy: ProfileViewDelegateSpy!

    override func setUp() {
        super.setUp()
	profileDelegateSpy = .init()
	sut = .init()
	sut.delegate = profileDelegateSpy
    }

    override func tearDown() {
        profileViewDelegateSpy = nil
	sut = nil
	super.tearDown()
    }

    ...

}
```
