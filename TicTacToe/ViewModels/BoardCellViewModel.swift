//
//  BoardCellViewModel.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

struct BoardCellViewModel {
    let mark: Mark

    var image: UIImage? {
        return self.mark.image
    }
}
