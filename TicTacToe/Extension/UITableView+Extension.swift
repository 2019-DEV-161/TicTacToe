//
//  UITableView+Extension.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

public extension UITableView {

    /// Registers a cell class for dequeueing. The reuseIdentifier will be the class name of the type
    ///
    /// - Parameter type: The cell class to register
    func registerCellClass<T: UITableViewCell>(ofType type: T.Type) {
        self.register(T.self, forCellReuseIdentifier: self.reuseIdentifierForCellClass(cellClass: type))
    }

    /// Dequeues a cell of a given type. The reuseidentifier used for dequeueing will be the class name.
    ///
    /// - Parameters:
    ///   - type: The type of which a new cell should be dequeued
    ///   - indexPath: The indexpath specifying the location of the cell
    /// - Returns: A UITableViewCell instance of the expected type
    func dequeueReusableCell<T: UITableViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return self.dequeueReusableCell(withIdentifier: self.reuseIdentifierForCellClass(cellClass: type), for: indexPath) as! T
        // swiftlint:enable force_cast
    }

    private func reuseIdentifierForCellClass(cellClass: AnyClass) -> String {
        return String(describing: cellClass.self)
    }

    /// Registers a header/footer class for dequeueing. The reuseIdentifier will be the class name of the type
    ///
    /// - Parameter type: The header/footer class to register
    func registerHeaderFooterClass<T: UITableViewHeaderFooterView>(ofType type: T.Type) {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: self.reuseIdentifierForHeaderFooterClass(headerFooterClass: type))
    }

    /// Dequeues a header/footer of a given type. The reuseidentifier used for dequeueing will be the class name.
    ///
    /// - Parameters:
    ///   - type: The type of which a new header/footer should be dequeued
    /// - Returns: A UITableViewHeaderFooterView instance of the expected type
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(ofType type: T.Type) -> T {
        // swiftlint:disable force_cast
        return self.dequeueReusableHeaderFooterView(withIdentifier: self.reuseIdentifierForHeaderFooterClass(headerFooterClass: type)) as! T
        // swiftlint:enable force_cast
    }

    private func reuseIdentifierForHeaderFooterClass(headerFooterClass: AnyClass) -> String {
        return String(describing: headerFooterClass.self)
    }

}
