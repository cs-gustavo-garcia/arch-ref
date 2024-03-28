//
//  FirstViewDelegateSpy.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 22/03/24.
//

@testable import ArchrefApp

final class FirstViewDelegateSpy: FirstViewDelegate {
    
    private(set) var didTapActionButtonCalledCount: Int = 0
    
    func didTapActionButton() {
        didTapActionButtonCalledCount += 1
    }
    
}
