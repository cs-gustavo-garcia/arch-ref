//
//  FirstViewController.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

final class FirstViewController: UIViewController {
    
    let mainView: FirstView = .init()
    let viewModel: FirstViewModelProtocol
    
    init(viewModel: FirstViewModelProtocol = FirstViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        mainView.delegate = self
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
}

extension FirstViewController: FirstViewModelDelegate {
    
    func updateView() {
        mainView.content = viewModel.content
    }
    
}

extension FirstViewController: FirstViewDelegate {
    
    func didTapActionButton() {
        let viewController: SecondViewController = .init()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
