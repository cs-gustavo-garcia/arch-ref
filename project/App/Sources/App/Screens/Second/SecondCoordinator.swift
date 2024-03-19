//
//  SecondCoordinator.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

final class SecondCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let SecondViewController: SecondViewController = SecondViewController()
        navigationController.viewControllers = [SecondViewController]
    }
}
