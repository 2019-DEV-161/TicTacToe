//
//  BoardCell.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

class BoardCell: BaseCollectionViewCell {

    var viewModel: BoardCellViewModel? {
        didSet {
            self.updateView()
        }
    }

    let imageView: UIImageView = UIImageView(forAutoLayout: ())

    override func setupSubviews() {
        self.contentView.addSubview(imageView)
    }

    override func setupConstraints() {
        self.imageView.pinToSuperViewEdges()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }

    private func reset() {
        self.imageView.image = nil
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }

    private func updateView() {
        guard let viewModel = self.viewModel else {
            self.reset()
            return
        }

        self.imageView.image = viewModel.image
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
