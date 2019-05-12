//
//  GameCell.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    var viewModel: GameCellViewModel? {
        didSet {
            self.updateView()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }

    private func reset() {
        self.textLabel?.text = nil
        self.imageView?.image = nil
    }

    private func updateView() {
        guard let viewModel = self.viewModel else {
            self.reset()
            return
        }

        self.textLabel?.text = viewModel.title
        self.imageView?.image = viewModel.icon
    }
}
