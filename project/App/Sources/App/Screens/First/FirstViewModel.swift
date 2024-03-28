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
    var content: FirstViewContent?
    private let dispatchQueueAsync: DispatchQueueAsync
    
    init(dispatchQueueAsync: DispatchQueueAsync = DispatchQueue.main) {
        self.dispatchQueueAsync = dispatchQueueAsync
    }
    
    func viewDidLoad() {
        dispatchQueueAsync.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else {
                return
            }
            self.content = .init(buttonTitle: "tap")
            self.delegate?.updateView()
        }
    }
}
