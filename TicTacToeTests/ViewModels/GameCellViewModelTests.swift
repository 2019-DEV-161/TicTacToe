//
//  GameCellViewModelTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import XCTest

class GameCellViewModelTests: XCTestCase {

    func testInit() {
        let title = "Title"

        let viewModel = GameCellViewModel(title: title, icon: nil)

        XCTAssertEqual(viewModel.title, title)
        XCTAssertNil(viewModel.icon)
    }

}
