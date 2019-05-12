//
//  UIViewController+Extension.swift
//  TicTacToe
//
//  Created by 2019_DEV_161 on 12/05/2019.
//  Copyright © 2019 2019_DEV_161. All rights reserved.
//

import UIKit

extension UIViewController {

    /**
        Present an UIAlertController with a title, a message and a OK button

        - Parameter title: title to show to the user
        - Parameter message: message to show to the user
        - Parameter completionBlock: block to exectue when user click ok
    */
    @discardableResult
    public func present(title: String, message: String, completionBlock: (() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            completionBlock?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        return alertController
    }
}
