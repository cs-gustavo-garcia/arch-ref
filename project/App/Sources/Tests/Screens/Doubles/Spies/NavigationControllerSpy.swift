//
//  NavigationControllerSpy.swift
//  ArchrefAppTests
//
//  Created by gustavo.garcia.leite on 22/03/24.
//

@testable import ArchrefApp
import UIKit

final class NavigationControllerSpy: UINavigationController {
    
    private(set) var pushViewControllerCalledCount: Int = 0
    private(set) var pushViewControllerViewControllerReceived: UIViewController?
    private(set) var pushViewControllerAnimatedReceived: Bool = false
    
    private(set) var presentCalledCount: Int = 0
    private(set) var presentViewControllerReceived: UIViewController?
    private(set) var presentAnimatedReceived: Bool = false
    private(set) var presentCompletionReceived: (() -> Void)?
    
    init(sut: UIViewController) {
        super.init(rootViewController: UIViewController())
        pushViewController(sut, animated: false)
        pushViewControllerCalledCount = 0
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCalledCount += 1
        pushViewControllerViewControllerReceived = viewController
        pushViewControllerAnimatedReceived = animated
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        presentCalledCount += 1
        presentViewControllerReceived = viewControllerToPresent
        presentAnimatedReceived = flag
        presentCompletionReceived = completion
    }
}
