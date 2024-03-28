//
//  FirstViewTestCase.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

@testable import ArchrefApp
import XCTest

final class FirstViewTestCase: XCTestCase {
    
    var sut: FirstView!
    var delegateSpy: FirstViewDelegateSpy!
    
    override func setUp() {
        super.setUp()
        delegateSpy = FirstViewDelegateSpy()
        sut = FirstView()
        sut.delegate = delegateSpy
    }
    
    override func tearDown() {
        sut = nil
        delegateSpy = nil
        super.tearDown()
    }
    
    func test_setupView_shouldBeBuiltCorrectly() {
        XCTAssertEqual(sut.subviews[0], sut.button)
        XCTAssertEqual(sut.backgroundColor, .white)
    }
    
    func test_changeScreen_shouldCallDidTapActionButtonDelegate() {
        sut.changeScreen()
        
        XCTAssertEqual(delegateSpy.didTapActionButtonCalledCount, 1)
    }
    
    func test_updateView_shouldUseContentToUpdateView() {
        sut.content = .init(buttonTitle: "test")
        
        XCTAssertEqual(sut.button.titleLabel?.text, "test")
    }
}
