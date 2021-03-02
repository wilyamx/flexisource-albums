//
//  FLXAlbumDO.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import UIKit

class FLXAlbumDO: FLXDisplayObject {
    var id: Int32
    var releaseCover: String
    var releaseLabel: String
    
    init (id: Int32,
          releaseCover: String,
          releaseLabel: String) {
        self.id = id
        self.releaseCover = releaseCover
        self.releaseLabel = releaseLabel
    }
}
