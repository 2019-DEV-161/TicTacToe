//
//  UICollectionView+Extension.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import Foundation

import UIKit

public extension UICollectionView {

    /// Registers a cell class for dequeueing. The reuseIdentifier will be the class name of the type
    ///
    /// - Parameter type: The cell class to register
    func registerCellClass<T: UICollectionViewCell>(ofType type: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: self.reuseIdentifierForCellClass(cellClass: type))
    }

    /// Dequeues a cell of a given type. The reuseidentifier used for dequeueing will be the class name.
    ///
    /// - Parameters:
    ///   - type: The type of which a new cell should be dequeued
    ///   - indexPath: The indexpath specifying the location of the cell
    /// - Returns: A UICollectionViewCell instance of the expected type
    func dequeueReusableCell<T: UICollectionViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return self.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifierForCellClass(cellClass: type), for: indexPath) as! T
        // swiftlint:enable force_cast
    }

    private func reuseIdentifierForCellClass(cellClass: AnyClass) -> String {
        return String(describing: cellClass.self)
    }

}
