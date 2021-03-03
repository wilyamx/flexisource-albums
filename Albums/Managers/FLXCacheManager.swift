//
//  FLXCacheManager.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import Foundation
import UIKit

class FLXCacheManager {
    static let shared = FLXCacheManager()
    
    public lazy var imageCache = NSCache<NSString, UIImage>()
    
    // https://blewjy.github.io/ios/swift/4/basic/2019/02/27/image-caching-in-swift-4.html
    // https://betterprogramming.pub/cache-images-in-a-uicollectionview-using-nscache-in-swift-5-b70ebf090521
    
    init() {
        let urlCache = URLCache(
            memoryCapacity: 4 * 1024 * 1024,
            diskCapacity: 300 * 1024 * 1024,
            diskPath: nil)
        URLCache.shared = urlCache
    }
    
}


