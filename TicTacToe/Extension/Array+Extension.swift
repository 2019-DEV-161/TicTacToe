//
//  Array+Extension.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func allEqual() -> Bool {
        if let firstElem = first {
            return !dropFirst().contains { $0 != firstElem }
        }
        return true
    }
}

extension Array {

    
    @discardableResult mutating func removeObject<U: Equatable>(_ object: U) -> Bool {
        for (idx, objectToCompare) in self.enumerated() {
            guard let to = objectToCompare as? U,
                object == to else { return false }
            self.remove(at: idx)
            return true
        }
        return false
    }

    func findItemOfType<U>(_ itemToFind: U.Type) -> U? {
        for case let item as U in self {
            return item
        }
        return nil
    }
}
