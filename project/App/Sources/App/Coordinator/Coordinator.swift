//
//  Coordinator.swift
//  ArchrefApp
//
//  Created by gustavo.garcia.leite on 13/03/24.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    init(navigationController: UINavigationController)
    func start()
}
