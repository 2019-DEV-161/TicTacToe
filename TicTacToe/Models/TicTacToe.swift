//
//  TicTacToe.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import Foundation

class TicTacToe {

    enum State: Equatable {
        case win(Player), draw, play
    }

    enum Error: LocalizedError {
        case alreadyPlayed
        case gameEnded

        var errorDescription: String? {
            switch self {
            case .alreadyPlayed:
                return "Invalid play"
            case .gameEnded:
                return "Game is finished"
            }
        }
    }

    private(set) var state: State = .play
    private let players: [Player]
    private var currentPlayerIndex = 0

    var currentPlayer: Player {
        return self.players[self.currentPlayerIndex]
    }

    init(player1: String, player2: String) {
        self.players = [Player(name: player1)]
    }

    func updateMark(at index: Int) throws {
        throw TicTacToe.Error.alreadyPlayed
    }

    func allMarks() -> [Mark] {
        return [Mark]()
    }
}
