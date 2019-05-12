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
    private let board = Board()
    private let players: [Player]
    private var currentPlayerIndex = 0
    private var currentMark = Mark.x

    var currentPlayer: Player {
        return self.players[self.currentPlayerIndex]
    }

    init(player1: String, player2: String) {
        self.players = [Player(name: player1), Player(name: player2)]
    }

    func updateMark(at index: Int) throws {
        do {
            let boardState = try self.board.updateMark(at: index, with: self.currentMark)
            switch boardState {
            case .play:
                self.state = .play
            case .full:
                self.state = .draw
            case .threeInARow:
                self.state = .win(self.currentPlayer)
            }
            self.nextPlayer()
        } catch Board.BoardError.boardIsFull {
            throw Error.gameEnded
        } catch Board.BoardError.alreadyPlayed {
            throw Error.alreadyPlayed
        } catch {
            print("Unexpected error: \(error).")
        }
    }

    func allMarks() -> [Mark] {
        return self.board.allMarks
    }

    private func nextPlayer() {
        self.currentPlayerIndex += 1
        self.currentMark = self.currentMark == .x ? .o : .x
        if self.currentPlayerIndex >= self.players.count {
            self.currentPlayerIndex = 0
        }
    }
}
