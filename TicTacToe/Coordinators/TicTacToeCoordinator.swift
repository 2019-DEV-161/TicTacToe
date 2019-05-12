//
//  TicTacToeCoordinator.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//
import UIKit

protocol TicTacToeCoordinatorCompletionDelegate: class {
    func didEnd(coordinator: TicTacToeCoordinator)
}

class TicTacToeCoordinator: Coordinator {

    weak var completionDelegate: TicTacToeCoordinatorCompletionDelegate?
    weak var startedViewController: UIViewController?
    weak var ticTacToeViewModel: TicTacToeViewModel?

    func start() {
        self.startedViewController = self.navigationController.topViewController

        weak var ticTacToeViewController: TicTacToeViewController?

        let onError: (String?) -> Void = { message in
            guard let message = message else { return }
            ticTacToeViewController?.present(title: "Error", message: message)
        }

        let onChange: (TicTacToe.State) -> Void = {
            ticTacToeViewController?.updateView(with: $0)
        }

        let viewModel = TicTacToeViewModel(onChange: onChange, onError: onError)
        let viewController = TicTacToeViewController(viewModel: viewModel)
        viewController.delegate = self
        ticTacToeViewController = viewController
        self.ticTacToeViewModel = viewModel

        self.navigationController.pushViewController(viewController, animated: true)

    }

    func complete() {
        if let startedViewController = self.startedViewController {
            self.navigationController.popToViewController(startedViewController, animated: true)
        } else {
            self.navigationController.popViewController(animated: true)
        }
        self.completionDelegate?.didEnd(coordinator: self)
    }
}

extension TicTacToeCoordinator: TicTacToeViewControllerDelegate {

    func didFinishGame(on ticTacToeViewController: TicTacToeViewController) {
        self.complete()
    }

    func didSelectItem(at index: Int, on ticTacToeViewController: TicTacToeViewController) {
        guard let viewModel = self.ticTacToeViewModel else { return }

        viewModel.updateMark(at: index)
    }

}
