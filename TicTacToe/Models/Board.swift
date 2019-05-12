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

    private var marks: [[Mark]]

    var allMarks: [Mark] {
        return self.marks.flatMap { $0 }
    }

    // MARK: - LifeCycle

    init() {
        self.marks = [[Mark]]()
    }

    // MARK: - Public

    func mark(at index: Int) throws -> Mark {
        throw BoardError.invalidPosition
    }

    func updateMark(at index: Int, with mark: Mark) throws -> State {
        return .play
    }
}
