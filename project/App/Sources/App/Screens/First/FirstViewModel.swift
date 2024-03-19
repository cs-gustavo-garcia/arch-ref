//
//  FirstViewModel.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import Foundation

protocol FirstViewModelProtocol: AnyObject {
    var delegate: FirstViewModelDelegate? { get set }
    func viewDidLoad()
}

protocol FirstViewModelDelegate: AnyObject {
    func updateView()
}

final class FirstViewModel: FirstViewModelProtocol {
    
    weak var delegate: FirstViewModelDelegate?
    
    func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.delegate?.updateView()
        }
    }
}
