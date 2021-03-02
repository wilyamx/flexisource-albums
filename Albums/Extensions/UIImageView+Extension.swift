//
//  UIImageView+Extension.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func load(url: URL,
              completion: @escaping (UIImage) -> Void) {
        
        let cache = FLXCacheManager.shared.imageCache
        let key = url.absoluteString as NSString
        if let image = cache.object(forKey: key) {
            self.image = image
            completion(image)
            return
        }
        
        guard FLXNetworkManager.shared.isConnectedToNetwork() else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DebugInfoKey.cache.log(info: "Couldn't download image from \(url.absoluteURL) :: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            if let image = UIImage(data: data) {
                cache.setObject(image, forKey: key)
                DebugInfoKey.cache.log(info: "Image cached from \(key)")
                completion(image)
            }

        }.resume()
        
    }
}
