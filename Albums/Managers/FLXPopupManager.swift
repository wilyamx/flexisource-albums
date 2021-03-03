//
//  FLXPopupManager.swift
//  Albums
//
//  Created by William S. Rena on 3/3/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import Foundation
import UIKit

class FLXPopupManager {
    static let shared = FLXPopupManager()

    public func popUpErrorDetails(
        presenter: UIViewController,
        title: String,
        message: String) {

        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { (action) -> Void in
             
            })

        let dialogMessage = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        dialogMessage.addAction(okAction)

        presenter.present(dialogMessage, animated: true, completion: nil)
    }
    
    public func popUpConfirmation(
        presenter: UIViewController,
        title: String,
        message: String,
        confirmed: @escaping () -> Void) {
       
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { (action) -> Void in
                confirmed()
            })
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: { (action) -> Void in
             
            })
        
        let dialogMessage = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        dialogMessage.addAction(okAction)
        dialogMessage.addAction(cancelAction)

        presenter.present(dialogMessage, animated: true, completion: nil)
    }
}
