//
//  AssertionsAdditions.swift
//  TicTacToeTests
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import Foundation
import XCTest

/// Assert equality of 2 UIImage based on their content, not allowing nil values
public func AssertEqualImage(_ lhs: UIImage?, _ rhs: UIImage?) {
    guard let lhs = lhs, let rhs = rhs else {
        XCTFail("Found unexpected nil in values")
        return
    }
    AssertEqualNotNil(lhs.pngData(), rhs.pngData())
}

/// Assert equality of 2 Equatable objects, not allowing nil values.
public func AssertEqualNotNil<T>(_ lhs: T?, _ rhs: T?) where T: Equatable {
    guard let lhs = lhs, let rhs = rhs else {
        XCTFail("Found unexpected nil in values")
        return
    }
    XCTAssertEqual(lhs, rhs)
}
