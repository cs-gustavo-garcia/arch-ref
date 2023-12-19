
## Princípios Básicos

- Este guia é um documento adicional ao [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/). Estas regras não devem contradizer aquele documento.

- Estas regras não devem ir contra o comportamento padrão de identação do Xcode <kbd> ^ </kbd> + <kbd> I </kbd>.


## Conteúdo


1. [Nomenclatura](#nomenclatura)

2. [Style](#style)

    2. [Style](#style)

    2. [Closures](#closures)

    2. [Operators](#operators)

3. [Padrões](#padrões)

4. [Organização](#organização)

5. [Testes](#testes)

6. [Alterações](#alterações)


## Nomenclatura
 

- Usar **PascalCase** para nomes de tipos (types - Class, Struct, etc) e protocolos e **lowerCamelCase** para o restante.

    Exemplo:
   
    ```swift
    protocol SpaceGroup {
        // ...
    }
   
    class Spaceship {
        // ...
    }
   
    class SpaceFleet: SpaceGroup {

        var ships: [Spaceship] = []
        let worldName: String = "Earth"


        func addShip(_ ship: Spaceship) {
            // ...
        }

    }

    let myFleet = SpaceFleet()
    ```

- Nomear booleanos de forma a deixar claro que são booleanos e não outros tipos.

    Exemplo: **`isSpaceship`**, **`hasSpacesuit`**

- Acrônimos utilizados em nomes (ex: **`URL`**) devem ser capitalizados, exceto quando aparecem no início de um nome, neste caso deve ser usado o padrão **lowerCamelCase**.
   
    Exemplo:

    ```swift
    // Not Preferred

    class UrlValidator {

        func isValidUrl(_ URL: URL) -> Bool {
            // ...
        }

        func isUrlReachable(_ URL: URL) -> Bool {
            // ...
        }

    }  

    let URLValidator = UrlValidator().isVa``lidUrl(/* some URL */)
    ```   

    ```swift
    // Preferred

    class URLValidator {       

        func isValidURL(_ url: URL) -> Bool {
            // ...
        }       

        func isURLReachable(_ url: URL) -> Bool {
            // ...
        }

    }   

    let urlValidator = URLValidator().isValidURL(/* some URL */)

    ``` 

- Nomes devem ser escritos com o elemento **mais geral** no início na palavra e o **mais específico** no final. O significado de "mais geral" depende do contexto, mas para simplificar pode-se pensar no elemento que irá facilitar  a localização daquele item no código.
 
    Exemplo: 

    ```swift
    // Not Preferred

    let rightTitleMargin: CGFloat
    let leftTitleMargin: CGFloat  

    let bodyRightMargin: CGFloat
    let bodyLeftMargin: CGFloat
    ```
  
    ```swift
    // Preferred

    let titleMarginRight: CGFloat
    let titleMarginLeft: CGFloat   

    let bodyMarginRight: CGFloat
    let bodyMarginLeft: CGFloat
    ``` 

- Adicione ao nome uma dica sobre o tipo para evitar ambiguidade.

    Exemplo:   

    ```swift
    // Not Preferred

    let title: String
    let cancel: UIButton

    ```   

    ```swift
    // Preferred

    let titleText: String
    let cancelButton: UIButton

    ```

- Funções de Delegates devem ser nomeadas no pretérito.
 
    Exemplo:
  
    ```swift
    // Not Preferred

    class ExperiencesViewController {     

        private func handleBookButtonTap() {
            // ...
        }
       
        private func modelChanged() {
            // ...
        }

    }
    ```   

    ```swift
    // Preferred

    class ExperiencesViewController {       

        private func didTapBookButton() {
            // ...
        }
       
        private func modelDidChange() {
            // ...
        }

    }
    ```
 
- Não nomear actions usando o Delegate Pattern. Uma `"Target-action"` segue o padrão `“Command Pattern”` e por isso deve ser nomeada como um comando.
 
    Exemplo:
   
    ```swift
    // Not Preferred

    #selector(didTapSaveButton(sender:))
    #selector(didHitSend(sender:))
    ```
   
    ```swift
    // Preferred

    #selector(saveProfile(sender:))
    #selector(sendMessage(sender:))
    ```
 
- Nomeie os protocolos de acordo com a utilidade. 
	- Se somente for uma "Interface", nomeie o final com "**Protocol**";
	- E for um "Delegate", nomeie o final com "**Delegate**".
 
    Exemplo:
   
    ```swift
    protocol ViewModelProtocol {}
    protocol ViewModelDelegate {}
    ```
 
- Usar US English na nomenclatura para corresponder à API da Apple.
 
    Exemplo:

    ```swift
    // Not Preferred

    let colour = "red"
    ```
 
    ```swift
    // Preferred

    let color = "red"
    ```
   
- Não usar `*Controller` em nomes de classes que não são View Controllers.

    > **Por quê?**<br>

    > Controller é um sufixo sobrecarregado que não fornece informações sobre as responsabilidades da classe.
   
## Style

- Pular linhas no começo e no final de classes e extensões. Você também pode pular linhas dentro de funções para melhor organização de suas responsabilidades quando necessário.

- Sempre pular uma linha entre definições de métodos para evitar aglutinação.
 
    Exemplo:
   
    ```swift
    // Not Preferred

    func doSomething() {
        // Do something
    }

    func doSomethingElse() {
        // Do something else
    }

    func doAnotherThing() {
        // Do another thing
    }
    ```

    ```swift
    // Preferred

    func doSomething() {
        // Do something
    }
   
    func doSomethingElse() {
        // Do something else
    }
   
    func doAnotherThing() {
        // Do another thing
    }
    ```

- Agrupar variáveis de acordo com o seu modificador de acesso, seguindo uma ordem, do menos restrito para o mais restrito.

    Exemplo:
   
    ```swift
    // Not Preferred

    private var service: ServiceProtocol?
    public var summary: SummaryProtocol
    private var selectedImages: [UIImage]
    internal var deviceId: Int
    private var selectedDocuments: [UIDocument]
    internal var isRoot: Bool
    private var selectedIndex: Int
    fileprivate var tableView: UITableView
    public var displayNameLabel: UILabel
    fileprivate var collectionView: UICollectionView
    public var titleLabel: UILabel
    public var subtitleLabel: UILabel
    internal var buttonTitle: String
    ```

    ```swift
    // Preferred

    public var summary: SummaryProtocol
    public var displayNameLabel: UILabel
    public var titleLabel: UILabel
    public var subtitleLabel: UILabel  

    internal var deviceId: Int
    internal var isRoot: Bool
    internal var buttonTitle: String

    private var service: ServiceProtocol?
    private var selectedImages: [UIImage]
    private var selectedDocuments: [UIDocument]
    private var selectedIndex: Int 

    fileprivate var tableView: UITableView
    fileprivate var collectionView: UICollectionView
    ```

- Não incluir tipos onde eles puderem ser facilmente inferidos.

    Exemplo: 

    ```swift
    // Not Preferred

    let enterprise: Spaceship = Spaceship()
    // or
    let enterprise = Spaceship()
   
    func someDirection() -> Direction {
        return Direction.left
    }
    
    func checkDirection() {
	    if let direction = enterprise.direction,
		    direction == Direction.left {
		    doSomethingWithTheDirection(direction)
	    }
    }

    ```
   
    ```swift
    // Preferred

    let enterprise: Spaceship = .init()   

    func someDirection() -> Direction {
        return .left
    }
    
	func checkDirection() {
	    if let direction: Direction = enterprise.direction,
		    direction == .left {
		    doSomethingWithTheDirection(direction)
	    }
    }
    ```

- Use `// MARK: -` para separar implementações de protocolo, identificar extensions e fazer uma melhor organização do código.
   
- Não usar `self` a menos que seja necessário para desambiguação ou quando for requerido pela linguagem.

    Exemplo:
 
    ```swift
    // Not Preferred

    init(name: String, speakEnglish: Bool) {
        self.name = name
        self.isEnglishSpeaker = speakEnglish
    }

    func giveSpeech() {
        self.calmDown()
        self.startTalking()
    }
    ```
  
    ```swift
    // Preferred

    init(userName: String, speakEnglish: Bool) {
        name = userName
        isEnglishSpeaker = speakEnglish
    }
   
    func giveSpeech() {
        calmDown()
        startTalking()
    }
    ```   

    **Obs:** Devemos tentar evitar a ambiguidade buscando um nome diferente para os parâmetros. Caso não seja possível encontrar uma palavra apropriada e o `self` seja necessário para desambiguação os outros pode-se usar `self` em todos os elementos de um init ou função para padronização.  

    Exemplo:  

    ```swift
    // Preferred

    init(name: String, speakEnglish: Bool) {
        self.name = name
        self.isEnglishSpeaker = speakEnglish
    } 

    func giveSpeech() {
        calmDown()
        startTalking()
    }
    ```   

- Nomear os membros das tuplas para melhor clareza do código. **Importante: Se você precisar de mais de 3 campos, você provavelmente deveria estar usando uma struct ou algum outro elemento.** 

    Exemplo:   

    ```swift
    // Not Preferred

    func getPosition() -> (CGFloat, CGFloat) {
        return (-23.601509, -46.694705)
    } 

    let position = getPosition()
    print(position.0)
    ``` 

    ```swift
    // Preferred

    func getPosition() -> (lat: CGFloat, long: CGFloat) {
        return (lat: -23.601509, long: -46.694705)
    }

    let position = getPosition()
    print(position.lat)
    ``` 

- Ao fazer uso de uma tupla em uma declaração de `case`, o `let`  pode ser adicionado imediatamente após o `case`, dessa forma não é necessário adicionar um `let` para cada item da tupla.

    Exemplo:
   
    ```swift
    // Not Preferred

    public var parameters: Parameters? {
        switch self {
        case .createDispute(let authorizationId):
            return [
                "authorization_id": authorizationId,
            ]
        default:
            return nil
        }
    } 

    public var parameters: Parameters? {
        switch self {
        case .createDispute(let authorizationId, let modality, let treeAnswers):
            return [
                "authorization_id": authorizationId,
                "modality": modality,
                "treeAnswers": treeAnswers,
            ]
        default:
            return nil
        }
    }
    ```   

    ```swift
    // Preferred

    public var parameters: Parameters? {
        switch self {
        case let .createDispute(authorizationId):
            return [
                "authorization_id": authorizationId,
            ]
        default:
            return nil
        }
    }
   
    public var parameters: Parameters? {
        switch self {
        case let .createDispute(authorizationId, modality, treeAnswers):
            return [
                "authorization_id": authorizationId,
                "modality": modality,
                "treeAnswers": treeAnswers,
            ]
        default:
            return nil
        }
    }
    ``` 

- Caso uma implementação ultrapasse o limite de 180 cartacteres na mesma linha você deve separar todos os parâmetros usando quebra de linhas de forma a manter o código alinhado a esquerda. Caso não ultrapasse o limite de caracteres você também pode quebrar linhas para melhor elegibilidade do código caso considere necessário.

    Exemplo:
   
    ```swift
    // Not Preferred

    service?.disputeCreation(router: DisputeRouter.createDispute(authorizationId: disputeSumary.authorizationId,
                                                                 modality: disputeSumary.modality,
                                                                 treeAnswers: disputeSumary.treeAnswers),
                             completion: { result in

                                switch result {
                                case let .success(disputeResult):
                                    self.disputeId = disputeResult.id
                                    self.endState(errorModel: nil)
                                case let .failure(error):
                                    self.endState(errorModel: PlaceholderViewModel(error: error))
                                }   
    })

    ```

    ```swift
    // Preferred

    service?.disputeCreation(
        router: DisputeRouter.createDispute(
            authorizationId: disputeSumary.authorizationId,
            modality: disputeSumary.modality,
            treeAnswers: disputeSumary.treeAnswers
        )
    ) { result in

        switch result {
        case let .success(disputeResult):
            self.disputeId = disputeResult.id
            self.endState(errorModel: nil)
        case let .failure(error):
            self.endState(errorModel: PlaceholderViewModel(error: error))
        }
    }
    ```

    No exemplo acima você também poderia criar uma variável para extrair o excesso de elementos do router da implementação.   

    Exemplo:  

    ```swift
    // Preferred

    let currentRouter: Router = DisputeRouter.createDispute(
        authorizationId: disputeSumary.authorizationId,
        modality: disputeSumary.modality,
        treeAnswers: disputeSumary.treeAnswers
    )
  
    service?.disputeCreation(router: currentRouter) { result in
        switch result {
        case let .success(disputeResult):
            self.disputeId = disputeResult.id
            self.endState(errorModel: nil)
        case let .failure(error):
            self.endState(errorModel: PlaceholderViewModel(error: error))
        }
    }
    ``` 

- Ao quebrar linhas para melhorar a elegibilidade de seu código certifique-se de quebrar linhas também no fechamento de chaves, parenteses e colchetes. 

    Exemplo: 

    ```swift
    // Not Preferred

    stackView = UIStackView(arrangedSubviews: [
        titleLabel,
        valueLabel,
        limitDateLabel,
        firstButton,
        secondButton,
        ])
    ```   

    ```swift
    // Preferred

    stackView = UIStackView(
        arrangedSubviews: [
            titleLabel,
            valueLabel,
            limitDateLabel,
            firstButton,
            secondButton,
        ]
    )
    ``` 

- Dê preferência por omitir o completion em suas implementações. 

    Exemplo: 

    ```swift
    // Not Preferred

    service?.disputes(router: DisputeRouter.currencies, completion: { [weak self] result in
        switch result {
        case .success:
            self?.endState(errorModel: nil)
        case let .failure(error):
            self?.endState(errorModel: PlaceholderViewModel(error: error))
        }
    })
    ```   

    ```swift
    // Preferred

    service?.disputes(router: DisputeRouter.currencies) { [weak self] result in
        switch result {
        case .success:
            self?.endState(errorModel: nil)
        case let .failure(error):
            self?.endState(errorModel: PlaceholderViewModel(error: error))
        }
    }
    ```   

- Usamos View Code, não adicione Storyboards ou XIB’s no projeto.

- É preferível iniciar as constantes e variáveis fora do método `init` da classe, a menos que seu valor seja recebido por injeção de dependência, cuja inicialização pode ser feita dentro do `init`.

    Exemplo:   

    ```swift
    // Not Preferred

    public class SpaceShip {       

        let photonTorpedo: Weapon
        let color: Color!      

        init() {        
	        photonTorpedo = Weapon()
	        color = .red
        }

    }
    ```   

    ```swift
    // Preferred

    public class SpaceShip {      

        let photonTorpedo: Weapon = .init()
        let internalSystem: System = {
           let system: System = .init()
           system.capacity = .large
           system.velocity = .fast
           return system
        }()
	let color: Color     

        init(color: Color) {
	        self.color = color
        }

    }
    ``` 

## Closures
 
- Closures de linha única devem ter um espaço dentro de cada chave.
 
    Exemplo:
   
    ```swift
    // Not Preferred

    let evenSquares = numbers.filter {$0 % 2 == 0}.map {  $0 * $0  }
    ```   

    ```swift

    // Preferred

    let evenSquares = numbers.filter { $0 % 2 == 0 }.map { $0 * $0 }
    ```

## Operators

- Operadores devem conter um único espaço de cada lado. Esta regra não se aplica a Range Operators (`1...3`). 

    Exemplo:  

    ```swift
    // Not Preferred

    let capacity = 1+2
    let capacity = currentCapacity   ?? 0
    let mask = (UIAccessibilityTraitButton|UIAccessibilityTraitSelected)
    let capacity=newCapacity
    let latitude = region.center.latitude - region.span.latitudeDelta/2.0
    ```  

    ```swift
    // Preferred

    let capacity = 1 + 2
    let capacity = currentCapacity ?? 0
    let mask = (UIAccessibilityTraitButton | UIAccessibilityTraitSelected)
    let capacity = newCapacity
    let latitude = region.center.latitude - (region.span.latitudeDelta / 2.0)
    ```   

## Padrões 

- De preferência por iniciar propriedades em tempo de inicialização em vez de usar force unwrapp. Uma notável exceção a esta regra é a `view` de uma `UIViewController`. 

    Exemplo:   

    ```swift
    // Not Preferred

    class SomeClass: NSObject {        

        var someValue: Int!
        var someString: String!        

        override init() {
            super.init()
            someValue = 5
        }    
   
    }
    ``` 

    ```swift
    // Preferred

    class SomeClass: NSObject {
        
        var someValue: Int = 5
        var someString: String?       

        override init() {
	        ...
            super.init()
        }  
    
    }
    ```   

- Evite executar qualquer trabalho intenso ou demorado em um `init()`. Evite coisas como: Abrir conexão com banco de dados, fazer requisições, ler grande quantidades de dados do disco, etc. Caso coisas como estas precisem ser feitas antes que o objeto esteja pronto para uso crie um método para isso, algo como um `start()` ou `setup()`.

- Evite criar funções globais sempre que possível.   

    Exemplo:   

    ```swift
    // Not Preferred

    func age(of person: Person, bornAt birthDate: Date) -> Int {
        // ...
    }   

    func jump(person: Person) {
        // ...
    }
    ```   

    ```swift
    // Preferred

    class Person {

        var birthDate: Date
   
        var age: Int {
            // ...
        }
       
        func jump() {
            // ...
        }

    }
    ```  

- Se você não precisar usar o valor, prefira validar se uma propriedade é `nil` em vez de usar uma ligação opcional.

    > **Por quê?**<br>
    > Uma verificação de nulidade deixa imediatamente claro qual é o objetivo daquela declaração. Uma ligação opcional é menos explicita neste caso.  

    Exemplo:  

    ```swift
    var imperialDalek: Dalek?

    ```   

    ```swift
    // Not Preferred

    if let imperialDalek = imperialDalek {
        exterminate()
    }
    ```  

    ```swift
    // Preferred

    if let imperialDalek {
        exterminate()
    }
    ```  
- Sempre que sua classe tiver um **Delegate**, é necessário declarar o protocolo do `Delegate` como `AnyObject`, e a variável delegate ser declarada na classe como `weak` e `?`. Com isso, conseguimos prevenir os ciclos de retenção, nos quais podem impedir que objetos sejam liberados da memória.

    Exemplo:
   
    ```swift
    // Not Preferred

    protocol ViewDelegate {
    	func didChangeValue()
    }
	
    final class View: UIView {

    var delegate: ViewDelegate!
  	
    func valueChanged() {
    	delegate.didChangeValue()
    }
    		
  }
    ```  

    ```swift
    // Preferred

    protocol ViewDelegate: AnyObject {
	func didChangeValue()
    }

    final class View: UIView {
		
    	weak var delegate: ViewDelegate?
	
    	func valueChanged() {
  		delegate?.didChangeValue()
  	}

  }
    ```
**Obs:** Deve ser utilizado `AnyObject` no protocolo ao invés de `class`, pois `class` está/será depreciado.

- Sempre que tiver funcionalidades assíncronas, que especialmente utilizem `closures`, é recomendável utilizar `weak self` caso esteje acessando alguma variável ou função da classe. Fazendo com que as `closures` causem vazamentos de memória no aplicativo.

    Exemplo:
   
    ```swift
    // Not Preferred

    final class ViewModel {
		
	var items: [String] = []
	
	func fetchItems() {
		network.fetch() { result
			self.items = result.items
		}
	}
		
   }
    ```  

    ```swift
    // Preferred

    final class ViewModel {
		
	var items: [String] = []
	
	func fetchItems() {
		network.fetch() { [weak self] result
			guard let self else {
				return
			}
			self.items = result.items
		}
	}
		
    }
    ```

- Deve-se sempre utilizar `final` nas classes que não são/serão herdadas.

    ```swift
    // Preferred
	
	final class WithoutInheritanceView: UIView {
		
	}
    ```

## Organização 

- Importe somente os módulos necessários pelo seu código fonte. Evite redundância, por exemplo, ao Importar o `UIKit`, não é necessário importar o `Foundation`. 

    Exemplo:
   
    ```swift
    // Not Preferred

    import Foundation
    import UIKit
    ```  

    ```swift
    // Preferred

    import UIKit
    ```

## Testes

No projeto temos um style guide apenas para testes que pode ser acessado aqui Style guide de testes (em progresso)

## Alterações

Alterações neste Style Guide não devem ser feitas de forma arbitrária, é importante que qualquer inclusão ou remoção de regras e recomendações sejam feitas com o conhecimento e concordância de todo o time.
