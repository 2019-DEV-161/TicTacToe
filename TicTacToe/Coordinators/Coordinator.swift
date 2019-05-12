//
//  Coordinator.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

class Coordinator: NSObject {

    var navigationController: UINavigationController
    private(set) var childCoordinators: [Coordinator] = [Coordinator]()

    private(set) weak var parent: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    func removeCoordinator(coordinator: Coordinator?) {
        if let coordinator = coordinator {
            if self.childCoordinators.removeObject(coordinator) {
                print("Removed coordinator \(type(of: coordinator))")
            } else {
                print(
                    "Removing coordinator \(type(of: coordinator)) failed, probably the coordinator was not added to the childCoordinators array.. :("
                )
            }
        }
    }

    func isCoordinatorEnded(viewController: UIViewController?) -> Bool {
        if let topVC = self.navigationController.topViewController, let startVC = viewController {
            if topVC == startVC {
                return true
            }
        }
        return false
    }

    func removeCoordinatorOfType<U>(coordinatorType: U.Type) {
        if let coordinator = self.childCoordinators.findItemOfType(coordinatorType) {
            self.removeCoordinator(coordinator: coordinator as? Coordinator)
        }
    }

    func addChild(coordinator: Coordinator) {
        coordinator.parent = self
        self.childCoordinators.append(coordinator)
    }

    func removeChild(coordinator: Coordinator) {
        guard self.childCoordinators.contains(coordinator) else {
            return
        }
        coordinator.parent = nil
        self.childCoordinators.removeObject(coordinator)
    }

    func removeAllChildren() {
        for child in self.childCoordinators {
            self.removeChild(coordinator: child)
        }
    }
}
