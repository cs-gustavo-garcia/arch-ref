
@testable import ArchrefApp
import XCTest

final class ViewControllerTestCase: XCTestCase {
    
    var sut: ViewController!
    
    override func setUp() {
        super.setUp()
        sut = ViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_loadView_shouldHaveCorrectViewType() {
        sut.loadView()
        XCTAssertTrue(sut.view is View)
    }
}
