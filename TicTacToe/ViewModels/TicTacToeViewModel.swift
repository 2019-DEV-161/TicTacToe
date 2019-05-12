//
//  TicTacToeViewModel.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

class TicTacToeViewModel {

    enum CellType {
        case piece(BoardCellViewModel)
    }

    let title = "Tic Tac Toe"

    var numberOfItemsPerLine: CGFloat {
        return CGFloat(ticTacToe.allMarks().count).squareRoot()
    }

    var currentPlayer: String {
        return "Current player is \(self.ticTacToe.currentPlayer.name)"
    }

    private let ticTacToe: TicTacToe
    private let onChange: ((TicTacToe.State) -> Void)?
    private let onError: ((String?) -> Void)?

    private var rows: [CellType] {
        didSet {
            self.onChange?(self.ticTacToe.state)
        }
    }

    init(onChange: ((TicTacToe.State) -> Void)? = nil, onError: ((String?) -> Void)? = nil) {
        self.onChange = onChange
        self.onError = onError
        self.ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
        self.rows = TicTacToeViewModel.rows(from: self.ticTacToe.allMarks())
    }

    static private func rows(from marks: [Mark]) -> [CellType] {
        return marks.map { CellType.piece(BoardCellViewModel(mark: $0)) }
    }

    private func refreshRows() {
        self.rows = TicTacToeViewModel.rows(from: self.ticTacToe.allMarks())
    }

    func numberOfRows() -> Int {
        return rows.count
    }

    func cellType(at index: Int) -> CellType {
        return rows[index]
    }

    func updateMark(at index: Int) {
        guard index >= 0, index <= self.rows.count else { return }
        do {
            try self.ticTacToe.updateMark(at: index)
            self.refreshRows()
        } catch let error as LocalizedError {
            self.onError?(error.errorDescription)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
