//
//  AppCoordinator.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    private weak var lastViewController: UIViewController?

    func start() {
        let viewModel = GameListViewModel()
        let viewController = GameListViewController(viewModel: viewModel)
        viewController.delegate = self

        self.navigationController.pushViewController(viewController, animated: true)
    }

    private func launchTicTacToe() {
        self.lastViewController = self.navigationController.topViewController

        let coordinator = TicTacToeCoordinator(navigationController: self.navigationController)
        coordinator.completionDelegate = self
        coordinator.start()
        self.addChild(coordinator: coordinator)
    }

    private func popToLastViewController() {
        if let lastViewController = self.lastViewController {
            self.navigationController.popToViewController(lastViewController, animated: true)
        } else {
            self.navigationController.popViewController(animated: true)
        }
    }
}

extension AppCoordinator: GameListViewControllerDelegate {

    func didSelect(game: GameListViewModel.GameIdentifier, on gameListViewController: GameListViewController) {
        switch game {
        case .ticTacToe:
            self.launchTicTacToe()
        }
    }

    func didTapBack(on gameListViewController: GameListViewController) { }
}

extension AppCoordinator: TicTacToeCoordinatorCompletionDelegate {

    func didEnd(coordinator: TicTacToeCoordinator) {
        self.removeChild(coordinator: coordinator)
        self.popToLastViewController()
    }
}
