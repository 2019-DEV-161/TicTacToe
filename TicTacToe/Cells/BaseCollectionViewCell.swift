//
//  BaseCollectionViewCell.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

/// Base UICollectionViewCell class for all CollectionViewCell subclasses. This cell adds an easy mechanism to add constraints in code.
/// To do so:
/// - override `setupSubviews` to setup all the subviews
/// - override `setupConstraints` to add all the constraints
open class BaseCollectionViewCell: UICollectionViewCell {

    private var didSetupConstraints: Bool = false

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    private func setup() {
        self.setupSubviews()
        self.contentView.setNeedsUpdateConstraints()
    }

    override open func updateConstraints() {
        if !didSetupConstraints {
            self.didSetupConstraints = true
            self.setupConstraints()
        }

        super.updateConstraints()
    }

    override open func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if !didSetupConstraints {
            self.didSetupConstraints = true
            self.setupConstraints()
        }
        super.apply(layoutAttributes)
    }

    /// Override this function to set up all subviews
    open func setupSubviews() {
        fatalError("\(type(of: self)): setupSubviews should be overwritten")
    }

    /// Do the setup of your constraints here. Method will only be called once
    open func setupConstraints() {
        fatalError("\(type(of: self)): setupConstraints should be overwritten")
    }

}
