//
//  SecondViewController.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

final class SecondViewController: UIViewController {
    
    let mainView: SecondView = .init()
    let viewModel: SecondViewModelProtocol
    
    init(viewModel: SecondViewModelProtocol = SecondViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SecondView()
    }
    
}
