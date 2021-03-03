//
//  FLXAlbumCollectionViewCell.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import UIKit

class FLXAlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgvAlbum: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgvAlbum.image = UIImage(named: "film-placeholder")
    }

    func configureViewCell(displayObject: FLXAlbumDO) {
        self.imgvAlbum.image = UIImage(named: "film-placeholder")
        
        let imageUrlString = displayObject.releaseCover
        if imageUrlString.count > 0 {
            if let url = URL(string: imageUrlString) {
                self.imgvAlbum.load(
                    url: url,
                    completion: { image in

                    })
            }

        }
        
    }
}
