//
//  BaseViewController.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

/// Base UIViewController class for all UIViewController subclasses. This controller adds an easy mechanism to add constraints in code.
/// To do so:
/// - override `setupLoadView` to setup all the subviews
/// - override `setupConstraints` to add all the constraints
/// - override `setupTitle` to configure title for the controller
class BaseViewController: UIViewController {

    private(set) var didSetupConstraints: Bool = false

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.white

        self.setupLoadView()
        view.setNeedsUpdateConstraints()
        self.setupTitle()
    }

    func setupTitle() {
        fatalError("should be overwritten")
    }

    func setupLoadView() {
        fatalError("should be overwritten")
    }

    func setupConstraints() {
        fatalError("should be overwritten")
    }

    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}
