//
//  Play.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

enum Mark: Equatable {
    case x, o, empty

    var image: UIImage? {
        switch self {
        case .x:
            return UIImage(named: "x_icon")
        case .o:
            return UIImage(named: "o_icon")
        case .empty:
            return nil
        }
    }
}
