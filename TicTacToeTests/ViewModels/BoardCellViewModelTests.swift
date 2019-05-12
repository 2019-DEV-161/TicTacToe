//
//  BoardCellViewModelTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import XCTest

class BoardCellViewModelTests: XCTestCase {

    func testInit() {
        let viewModel = BoardCellViewModel(mark: .x)
        XCTAssertEqual(viewModel.mark, .x)
        AssertEqualImage(viewModel.image, Mark.x.image)
    }

}
