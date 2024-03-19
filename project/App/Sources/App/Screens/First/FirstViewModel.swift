//
//  FirstViewModel.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import Foundation

struct FirstViewContent {
    let buttonTitle: String
}

protocol FirstViewModelProtocol: AnyObject {
    var delegate: FirstViewModelDelegate? { get set }
    var content: FirstViewContent? { get }
    func viewDidLoad()
}

protocol FirstViewModelDelegate: AnyObject {
    func updateView()
}

final class FirstViewModel: FirstViewModelProtocol {
    
    weak var delegate: FirstViewModelDelegate?
    let content: FirstViewContent?
    
    init() {
        content = .init(buttonTitle: "tap")
    }
    
    func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.delegate?.updateView()
        }
    }
}
