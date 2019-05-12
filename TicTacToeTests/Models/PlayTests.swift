//
//  PlayTests.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import XCTest

class MarkTests: XCTestCase {

    func testImage() {
        XCTAssertNil(Mark.empty.image)
        AssertEqualImage(Mark.x.image, UIImage(named: "x_icon"))
        AssertEqualImage(Mark.o.image, UIImage(named: "o_icon"))
    }
}
