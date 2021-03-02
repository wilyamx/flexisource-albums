//
//  FLXConstants.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import Foundation
import UIKit

struct TWKReference {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
}

public enum DebugInfoKey: String {
    case database = "[DATABASE]>>"
    case users = "[USERS]>>"
    case api = "[API]>>"
    case error = "[ERROR]>>"
    case cache = "[CACHE]>>"
    
    func log(info: String) {
        print("\(self.rawValue) \(info)")
    }
}

public enum TWKScreen {
    case userDetails
   
    public var segueIdentifier: String {
        switch self {
        case .userDetails:
            return "UserDetailsSegue"
        }
    }
}
