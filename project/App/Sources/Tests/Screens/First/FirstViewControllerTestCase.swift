@testable import ArchrefApp
import XCTest

final class FirstViewControllerTestCase: XCTestCase {
    
    var sut: FirstViewController!
    var viewModelSpy: FirstViewModelSpy!
    var navigationControllerSpy: NavigationControllerSpy!
    
    override func setUp() {
        super.setUp()
        viewModelSpy = FirstViewModelSpy()
        sut = FirstViewController(viewModel: viewModelSpy)
        navigationControllerSpy = .init(sut: sut)
        
    }
    
    override func tearDown() {
        sut = nil
        viewModelSpy = nil
        navigationControllerSpy = nil
        super.tearDown()
    }
    
    func test_init_shouldImplementViewModelDelegate() {
        XCTAssertNotNil(sut.viewModel.delegate)
    }
    
    func test_loadView_shouldHaveCorrectViewType() {
        sut.loadView()
        guard let view = sut.view as? FirstView else {
            return XCTFail("Expected FirstView type")
        }
        XCTAssertNotNil(view.delegate)
    }
    
    func test_viewDidLoad_shouldCallViewModelViewDidLoad() {
        sut.viewDidLoad()
        XCTAssertEqual(viewModelSpy.viewDidLoadCalledCount, 1)
    }
    
    func test_updateView_shouldUpdateViewContent() {
        sut.updateView()
        XCTAssertEqual(viewModelSpy.content?.buttonTitle, sut.mainView.content?.buttonTitle)
    }
    
    func test_didTapActionButton_shouldPresentSecondViewController() {
        sut.didTapActionButton()
        XCTAssertEqual(navigationControllerSpy.pushViewControllerCalledCount, 1)
        XCTAssertTrue(navigationControllerSpy.pushViewControllerViewControllerReceived is SecondViewController)
        XCTAssertTrue(navigationControllerSpy.pushViewControllerAnimatedReceived)
    }
}
