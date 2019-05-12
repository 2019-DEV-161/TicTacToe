//
//  PlayerTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import XCTest

class PlayerTests: XCTestCase {

    func testInit() {
        let player = Player(name: "test")
        XCTAssertEqual(player.name, "test")
    }
}
