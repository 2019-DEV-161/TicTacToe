//
//  GameListViewModelTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import XCTest

class GameListViewModelTests: XCTestCase {

    func testTitle() {
        let viewModel = GameListViewModel()
        XCTAssertEqual(viewModel.title, "Game List")
    }

    func testNumberOfRows() {
        let viewModel = GameListViewModel()
        XCTAssertEqual(viewModel.numberOfRows(), 1)
    }

    func testRowOrder() {
        let viewModel = GameListViewModel()

        let indexPath = IndexPath(row: 0, section: 0)
        let gameIdentifier = viewModel.gameIdentifier(at: indexPath)
        XCTAssertEqual(gameIdentifier, GameListViewModel.GameIdentifier.ticTacToe)
    }

    func testContent() {
        let viewModel = GameListViewModel()

        let indexPath = IndexPath(row: 0, section: 0)
        guard case .game(let cellViewModel) = viewModel.cellType(at: indexPath) else {
            XCTFail("Incorrect cell type at \(indexPath)")
            return
        }

        XCTAssertEqual(cellViewModel.title, GameListViewModel.GameIdentifier.ticTacToe.rawValue)
        XCTAssertNil(cellViewModel.icon)
    }
}
