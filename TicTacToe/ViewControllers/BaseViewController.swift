//
//  BaseViewController.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

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
