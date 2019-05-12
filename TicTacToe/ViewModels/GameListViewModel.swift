//
//  GameListViewModel.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import Foundation

class GameListViewModel {

    enum CellType {
        case game(viewModel: GameCellViewModel)
    }

    enum GameIdentifier: String {
        case ticTacToe = "Tic Tac Toe"
    }

    private struct Row {
        let cellIdentifier: GameIdentifier
        let cellType: CellType
    }

    let title = "Game List"

    private let rows: [Row]

    init() {
        self.rows = [
            Row(cellIdentifier: .ticTacToe,
                cellType: CellType.game(viewModel: GameCellViewModel(title: GameIdentifier.ticTacToe.rawValue, icon: nil)))
        ]
    }

    func numberOfRows() -> Int {
        return rows.count
    }

    func cellType(at indexPath: IndexPath) -> CellType {
        return rows[indexPath.row].cellType
    }

    func gameIdentifier(at indexPath: IndexPath) -> GameIdentifier {
        return rows[indexPath.row].cellIdentifier
    }
}
