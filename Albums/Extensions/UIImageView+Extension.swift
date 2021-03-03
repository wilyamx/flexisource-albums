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
        let key = url.lastPathComponent as NSString
        if let image = cache.object(forKey: key) {
            DispatchQueue.main.async {
                self.image = image
            }
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
                DispatchQueue.main.async {
                    let imageSize = self.frame.size
                    let renderer = UIGraphicsImageRenderer(size: imageSize)
                    let thumbnailImage = renderer.image {
                        (context) in
                        image.draw(in: CGRect(origin: .zero, size: imageSize))
                    }
                    
                    cache.setObject(thumbnailImage, forKey: key)
                    DebugInfoKey.cache.log(info: "Image cached from \(key)")
                    
                    self.image = thumbnailImage
                }
            }

        }.resume()
        
    }
}
