//
//  Board.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import Foundation

class Board {

    private typealias Position = (row: Int, column: Int)

    enum BoardError: Error {
        case invalidPosition
        case alreadyPlayed
        case boardIsFull
    }

    enum State {
        case threeInARow, full, play
    }

    private struct Constant {
        static let rows = 3
        static let columns = 3
    }

    private var marks: [[Mark]]

    var allMarks: [Mark] {
        return self.marks.flatMap { $0 }
    }

    // MARK: - LifeCycle

    init() {
        self.marks = Array(repeating: Array(repeating: .empty, count: Constant.columns), count: Constant.rows)
    }

    // MARK: - Public

    func mark(at index: Int) throws -> Mark {
        guard self.isValid(index: index) else {
            throw BoardError.invalidPosition
        }
        let position = self.mapIndexToRowAndColum(index: index)
        return self.marks[position.row][position.column]
    }

    func updateMark(at index: Int, with mark: Mark) throws -> State {
        guard self.isValid(index: index) else {
            throw BoardError.invalidPosition
        }
        guard !isBoardFull() else {
            throw BoardError.boardIsFull
        }
        let position = self.mapIndexToRowAndColum(index: index)
        guard self.marks[position.row][position.column] == .empty else {
            throw BoardError.alreadyPlayed
        }

        self.marks[position.row][position.column] = mark
        return self.calculateBoardState(for: position.row, column: position.column)
    }

    // MARK: - Private

    private func mapIndexToRowAndColum(index: Int) -> (row: Int, column: Int) {
        return (index/Constant.rows, index%Constant.columns)
    }

    private func isValid(index: Int) -> Bool {
        guard index >= 0, index < Constant.rows * Constant.columns else {
            return false
        }
        return true
    }

    private func calculateBoardState(for row: Int, column: Int) -> State {
        guard !self.isBoardFull() else {
            return .full
        }

        return hasWinner(for: row, column: column) ? .threeInARow : .play
    }

    private func hasWinner(for row: Int, column: Int) -> Bool {
        return self.checkVerticalWinner(in: column) ||
            self.checkHorizontalWinner(in: row) ||
            self.checkTransversalWinner()
    }

    private func checkHorizontalWinner(in row: Int) -> Bool {
        var marks = [Mark]()
        for column in 0..<Constant.columns {
            marks.append(self.marks[row][column])
        }

        return marks.allEqual() && marks.first ?? .empty != .empty
    }

    private func checkVerticalWinner(in column: Int) -> Bool {
        var marks = [Mark]()
        for row in 0..<Constant.rows {
            marks.append(self.marks[row][column])
        }

        return marks.allEqual() && marks.first ?? .empty != .empty
    }

    private func checkTransversalWinner() -> Bool {
        var transversal = [Mark]()
        var reverse = [Mark]()
        for row in 0..<Constant.rows {
            transversal.append(self.marks[row][row])
            reverse.append(self.marks[row][Constant.rows-1-row])
        }
        let winnerTransversal = transversal.allEqual() && transversal.first ?? .empty != .empty
        let winnerReverse = reverse.allEqual() && reverse.first ?? .empty != .empty
        return winnerTransversal || winnerReverse
    }

    private func isBoardFull() -> Bool {
        for mark in self.allMarks where mark == .empty {
            return false
        }
        return true
    }
}
