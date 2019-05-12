//
//  TicTacToeViewModelTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import XCTest

class TicTacToeViewModelTests: XCTestCase {

    func testTitle() {
        let viewModel = TicTacToeViewModel()
        XCTAssertEqual(viewModel.title, "Tic Tac Toe")

    }

    func testNumberOfRows() {
        let viewModel = TicTacToeViewModel()
        XCTAssertEqual(viewModel.numberOfRows(), 9)
    }

    func testCurrentPlayer() {
        let viewModel = TicTacToeViewModel()
        XCTAssertEqual(viewModel.currentPlayer, "Current player is Player1")

        viewModel.updateMark(at: 0)
        XCTAssertEqual(viewModel.currentPlayer, "Current player is Player2")
    }

    func testInit() {
        let viewModel = TicTacToeViewModel()

        for index in 0..<viewModel.numberOfRows() {
            guard case .piece(let cellViewModel) = viewModel.cellType(at: index) else {
                XCTFail("invalid cellType at (\(index)")
                return
            }
            XCTAssertEqual(cellViewModel.mark, .empty)
        }

    }

    func testUpdateMark() {
        let index = 0
        let viewModel = TicTacToeViewModel()
        viewModel.updateMark(at: index)

        guard case .piece(let cellViewModel) = viewModel.cellType(at: index) else {
            XCTFail("invalid cellType at (\(index)")
            return
        }
        XCTAssertTrue(cellViewModel.mark != .empty)

    }

    func testOnError() {

        let onErrorExpectation = expectation(description: "onError called")
        let viewModel = TicTacToeViewModel(onChange: nil, onError: { _ in
            onErrorExpectation.fulfill()
        })
        viewModel.updateMark(at: 0)
        viewModel.updateMark(at: 0)
        waitForExpectations(timeout: 1, handler: nil)

    }

    func testOnChange() {
        let onChangeExpectation = expectation(description: "onChange called")
        let viewModel = TicTacToeViewModel(onChange: { _ in
            onChangeExpectation.fulfill()
        }, onError: nil)

        viewModel.updateMark(at: 0)
        waitForExpectations(timeout: 1, handler: nil)

    }
}
