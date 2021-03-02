//
//  FLXAlbumsViewModel.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import UIKit

class FLXAlbumsViewModel: FLXViewModel {
    private var albums = [FLXAlbumDO]()
    
    func pullDown(completion: @escaping ([FLXAlbumDO]) -> ()) {
        self.albums.removeAll()
        self.albums.append(FLXAlbumDO(id: 1, releaseCover: "cover1.jpg", releaseLabel: "1982"))
        self.albums.append(FLXAlbumDO(id: 2, releaseCover: "cover1.jpg", releaseLabel: "1983"))
        self.albums.append(FLXAlbumDO(id: 3, releaseCover: "cover1.jpg", releaseLabel: "1984"))
        self.albums.append(FLXAlbumDO(id: 4, releaseCover: "cover1.jpg", releaseLabel: "1985"))
        completion(self.albums)
    }
    
    func pullUp() {
        
    }
    
}
