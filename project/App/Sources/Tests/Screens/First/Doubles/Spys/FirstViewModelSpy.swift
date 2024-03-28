//
//  FirstViewModelSpy.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 22/03/24.
//

@testable import ArchrefApp

final class FirstViewModelSpy: FirstViewModelProtocol {
    
    var delegate: FirstViewModelDelegate?
    var content: FirstViewContent? = .init(buttonTitle: "test")
    
    private(set) var viewDidLoadCalledCount: Int = 0
    
    init() {}
    
    func viewDidLoad() {
        viewDidLoadCalledCount += 1
    }
    
}
