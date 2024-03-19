//
//  FirstCoordinator.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

enum FirstCoordinatorFlow {
    case second
}

final class FirstCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let firstViewController: FirstViewController = FirstViewController(coordinatorDelegate: self)
        navigationController.viewControllers = [firstViewController]
    }
}

extension FirstCoordinator: FirstViewControllerFlowDelegate {
    
    func navigateTo(flow: FirstCoordinatorFlow) {
        switch flow {
        case .second:
            let secondCoordinator = SecondCoordinator(navigationController: navigationController)
            childCoordinators.append(secondCoordinator)
            secondCoordinator.start()
        }
    }
    
}
