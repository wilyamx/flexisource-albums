//
//  UIFont+Extension.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
  static func getFontName() -> String {
    return "Arial"
  }
  
  static func setRegular(fontSize size:CGFloat) -> UIFont {
      return UIFont(name: "\(getFontName())-MT", size: size) ?? UIFont.boldSystemFont(ofSize: size)
  }
  
  static func setBold(fontSize size:CGFloat) -> UIFont {
      return UIFont(name: "\(getFontName())-BoldMT", size: size) ?? UIFont.boldSystemFont(ofSize: size)
  }
}
