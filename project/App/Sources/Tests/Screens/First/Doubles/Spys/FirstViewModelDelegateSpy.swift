//
//  FirstViewModelDelegateSpy.swift
//  ArchrefAppTests
//
//  Created by gustavo.garcia.leite on 27/03/24.
//  Copyright © 2024 ArchrefAppOrg. All rights reserved.
//

@testable import ArchrefApp
import XCTest

final class FirstViewModelDelegateSpy: FirstViewModelDelegate {
    
    private(set) var updateViewCalledCount: Int = 0
    
    func updateView() {
        updateViewCalledCount += 1
    }
}
