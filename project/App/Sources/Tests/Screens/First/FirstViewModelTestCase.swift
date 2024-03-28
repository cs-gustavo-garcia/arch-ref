//
//  FirstViewModelTestCase.swift
//  ArchrefAppTests
//
//  Created by gustavo.garcia.leite on 27/03/24.
//  Copyright © 2024 ArchrefAppOrg. All rights reserved.
//

@testable import ArchrefApp
import XCTest

final class FirstViewModelTestCase: XCTestCase {
    
    var sut: FirstViewModel!
    var delegateSpy: FirstViewModelDelegateSpy!
    var dispatchQueueAsyncFake: DispatchQueueAsyncFake!
    
    override func setUp() {
        super.setUp()
        delegateSpy = FirstViewModelDelegateSpy()
        dispatchQueueAsyncFake = .init()
        sut = FirstViewModel(dispatchQueueAsync: dispatchQueueAsyncFake)
        sut.delegate = delegateSpy
    }
    
    override func tearDown() {
        sut = nil
        delegateSpy = nil
        dispatchQueueAsyncFake = nil
        super.tearDown()
    }
    
    func test_viewDidLoad_shouldCallUpdateViewAndUpdateContent() {
        sut.viewDidLoad()
        XCTAssertEqual(sut.content?.buttonTitle, "tap")
        XCTAssertEqual(delegateSpy.updateViewCalledCount, 1)
    }
}
