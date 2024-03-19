//
//  ViewTestCase.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

@testable import LocalSwiftPackage
import XCTest

final class ViewTestCase: XCTestCase {
    
    var sut: View!
    
    override func setUp() {
        super.setUp()
        sut = View()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_backgroundColor_shouldBeGreen() {
        XCTAssertEqual(sut.backgroundColor, .green)
    }
}
