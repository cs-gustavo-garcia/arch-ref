//
//  SecondViewControllerTestCase.swift
//  ArchrefAppTests
//
//  Created by gustavo.garcia.leite on 28/03/24.
//  Copyright © 2024 ArchrefAppOrg. All rights reserved.
//

@testable import ArchrefApp
import XCTest

final class SecondViewControllerTestCase: XCTestCase {
    
    var sut: SecondViewController!
    
    override func setUp() {
        super.setUp()
        sut = SecondViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_loadView_shouldHaveCorrectViewType() {
        sut.loadView()
        guard let view = sut.view as? SecondView else {
            return XCTFail("Expected SecondView type")
        }
    }
    
}
