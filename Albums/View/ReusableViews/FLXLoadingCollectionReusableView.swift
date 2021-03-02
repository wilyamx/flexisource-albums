//
//  FLXLoadingCollectionReusableView.swift
//  Albums
//
//  Created by William S. Rena on 3/3/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import UIKit

class FLXLoadingCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var actLoading: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.actLoading.color = .lightGray
    }
    
}
