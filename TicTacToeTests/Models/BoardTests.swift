//
//  BoardTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import XCTest

class BoardTests: XCTestCase {

    func testMarksCount() {
        let board = Board()
        XCTAssertEqual(board.allMarks.count, 9)
    }

    func testMarksAreAllEmpty() {
        let board = Board()
        for mark in board.allMarks {
            XCTAssertEqual(mark, .empty)
        }
    }

    func testChangeMark() {
        let board = Board()
        do {
            let state = try board.updateMark(at: 0, with: .x)
            XCTAssertEqual(state, .play)
            let mark = try board.mark(at: 0)
            XCTAssertEqual(mark, .x)
        } catch {
            XCTFail("Board throw error")
        }
    }

    func testInvalidMarkIndex() {
        let board = Board()
        do {
            _ = try board.mark(at: board.allMarks.count + 1)
            XCTFail("Call should throw")
        } catch Board.BoardError.invalidPosition {

        } catch {
            XCTFail("unexpected error")
        }
    }

    func testAlreadyPlay() {
        let board = Board()
        do {
            _ = try board.updateMark(at: 0, with: .x)
            _ = try board.updateMark(at: 0, with: .o)
            XCTFail("Call should throw")
        } catch Board.BoardError.alreadyPlayed {

        } catch {
            XCTFail("unexpected error")
        }
    }

    func testBoardIsFull() {
        let board = Board()
        do {
            var state: Board.State = .play
            for index in 0..<board.allMarks.count {
                state = try board.updateMark(at: index, with: .x)
            }
            XCTAssertEqual(state, .full)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testHasWinnerHorizontal1() {
        let board = Board()
        do {
            var state: Board.State = .play
            for index in 0..<3 {
                state = try board.updateMark(at: index, with: .x)
            }
            XCTAssertEqual(state, .threeInARow)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testHasWinnerHorizontal2() {
        let board = Board()
        do {
            var state: Board.State = .play
            for index in 3..<6 {
                state = try board.updateMark(at: index, with: .x)
            }
            XCTAssertEqual(state, .threeInARow)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testHasWinnerHorizontal3() {
        let board = Board()
        do {
            var state: Board.State = .play
            for index in 6..<9 {
                state = try board.updateMark(at: index, with: .x)
            }
            XCTAssertEqual(state, .threeInARow)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testHasWinnerVertical1() {
        let board = Board()
        do {
            var state: Board.State = .play
            state = try board.updateMark(at: 1, with: .x)
            state = try board.updateMark(at: 4, with: .x)
            state = try board.updateMark(at: 7, with: .x)
            XCTAssertEqual(state, .threeInARow)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testHasWinnerVertical2() {
        let board = Board()
        do {
            var state: Board.State = .play
            state = try board.updateMark(at: 2, with: .x)
            state = try board.updateMark(at: 5, with: .x)
            state = try board.updateMark(at: 8, with: .x)
            XCTAssertEqual(state, .threeInARow)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testHasWinnerVertical3() {
        let board = Board()
        do {
            var state: Board.State = .play
            state = try board.updateMark(at: 2, with: .x)
            state = try board.updateMark(at: 5, with: .x)
            state = try board.updateMark(at: 8, with: .x)
            XCTAssertEqual(state, .threeInARow)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testHasWinnerTransversal1() {
        let board = Board()
        do {
            var state: Board.State = .play
            state = try board.updateMark(at: 0, with: .x)
            state = try board.updateMark(at: 4, with: .x)
            state = try board.updateMark(at: 8, with: .x)
            XCTAssertEqual(state, .threeInARow)
        } catch {
            XCTFail("unexpected error")
        }
    }

    func testHasWinnerTransversalReverse() {
        let board = Board()
        do {
            var state: Board.State = .play
            state = try board.updateMark(at: 2, with: .x)
            state = try board.updateMark(at: 4, with: .x)
            state = try board.updateMark(at: 6, with: .x)
            XCTAssertEqual(state, .threeInARow)
        } catch {
            XCTFail("unexpected error")
        }
    }

}
