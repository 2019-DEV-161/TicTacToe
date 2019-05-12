//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import XCTest

class TicTacToeTests: XCTestCase {

    func testLocalizedError() {
        XCTAssertEqual(TicTacToe.Error.alreadyPlayed.errorDescription, "Invalid play")
        XCTAssertEqual(TicTacToe.Error.gameEnded.errorDescription, "Game is finished")
    }

    func testAllMarksAfterInit() {
        let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
        for mark in ticTacToe.allMarks() {
            XCTAssertEqual(mark, .empty)
        }
    }

    func testInitialState() {
        let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
        XCTAssertEqual(ticTacToe.state, .play)
    }

    func testUpdateMark() {
        do {
            let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
            try ticTacToe.updateMark(at: 0)
            XCTAssertTrue(ticTacToe.allMarks()[0] != .empty)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testNextPlayer() {
        do {
            let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
            XCTAssertEqual(ticTacToe.currentPlayer.name, "Player1")
            try ticTacToe.updateMark(at: 0)
            XCTAssertEqual(ticTacToe.currentPlayer.name, "Player2")
            try ticTacToe.updateMark(at: 1)
            XCTAssertEqual(ticTacToe.currentPlayer.name, "Player1")
            try ticTacToe.updateMark(at: 4)
            XCTAssertEqual(ticTacToe.currentPlayer.name, "Player2")
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testStateAfterUpdateMark() {
        do {
            let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
            try ticTacToe.updateMark(at: 0)
            XCTAssertEqual(ticTacToe.state, .play)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testUpdateMarkAlreadyPlayed() {
        do {
            let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
            try ticTacToe.updateMark(at: 0)
            try ticTacToe.updateMark(at: 0)
            XCTFail("method should throw")
        } catch TicTacToe.Error.alreadyPlayed {

        } catch {
            XCTFail("unexpected error")
        }
    }

    func testUpdateMarkGameIsFinish() {
        do {
            let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
            for index in 0..<ticTacToe.allMarks().count {
                try ticTacToe.updateMark(at: index)
            }
            try ticTacToe.updateMark(at: 0)
            XCTFail("method should throw")
        } catch TicTacToe.Error.gameEnded {

        } catch {
            XCTFail("unexpected error")
        }
    }

    func testDraw() {
        do {
            let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
            for index in 0..<ticTacToe.allMarks().count {
                try ticTacToe.updateMark(at: index)
            }
            XCTAssertEqual(ticTacToe.state, .draw)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testPlayer1Win() {
        do {
            let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
            try ticTacToe.updateMark(at: 0)
            try ticTacToe.updateMark(at: 5)
            try ticTacToe.updateMark(at: 1)
            try ticTacToe.updateMark(at: 6)
            try ticTacToe.updateMark(at: 2)

            guard case .win(let player) = ticTacToe.state else {
                XCTFail("state should be win")
                return
            }
            XCTAssertEqual(player.name, "Player1")
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testPlayer2Win() {
        do {
            let ticTacToe = TicTacToe(player1: "Player1", player2: "Player2")
            try ticTacToe.updateMark(at: 5)
            try ticTacToe.updateMark(at: 0)
            try ticTacToe.updateMark(at: 4)
            try ticTacToe.updateMark(at: 1)
            try ticTacToe.updateMark(at: 8)
            try ticTacToe.updateMark(at: 2)

            guard case .win(let player) = ticTacToe.state else {
                XCTFail("state should be win")
                return
            }
            XCTAssertEqual(player.name, "Player2")
        } catch {
            XCTFail("unexpected error")
        }
    }

}

