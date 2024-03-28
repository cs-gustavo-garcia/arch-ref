//
//  SecondViewTestCase.swift
//  ArchrefAppTests
//
//  Created by gustavo.garcia.leite on 28/03/24.
//  Copyright © 2024 ArchrefAppOrg. All rights reserved.
//

@testable import ArchrefApp
import XCTest

final class SecondViewTestCase: XCTestCase {
    
    var sut: SecondView!
    
    override func setUp() {
        super.setUp()
        sut = SecondView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_init_shouldDoSetupViewCorrectly() {
        XCTAssertEqual(sut.backgroundColor, .brown)
    }
    
}
