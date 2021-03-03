//
//  UICollectionView+Extension.swift
//  Albums
//
//  Created by William S. Rena on 3/3/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                 width: self.bounds.size.width,
                                                 height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.setRegular(fontSize: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func restoreFromEmptyMessage() {
        self.backgroundView = nil
    }
}
