//
//  FirstViewController.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

protocol FirstViewControllerFlowDelegate: AnyObject {
    func navigateTo(flow: FirstCoordinatorFlow)
}

final class FirstViewController: UIViewController {
    
    let mainView: FirstView = .init()
    let viewModel: FirstViewModelProtocol
    weak var coordinatorDelegate: FirstViewControllerFlowDelegate?
    
    init(coordinatorDelegate: FirstViewControllerFlowDelegate,
         viewModel: FirstViewModelProtocol = FirstViewModel()) {
        self.coordinatorDelegate = coordinatorDelegate
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = FirstView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
}

extension FirstViewController: FirstViewModelDelegate {
    
    func updateView() {
        mainView.updateView()
    }
    
}
