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
    
    private var offset: Int = 1
    
    let INITIAL_PAGE_SIZE: Int = 20
    let PAGE_SIZE: Int = 5
    
    func pullDown(completion: @escaping ([FLXAlbumDO]) -> ()) {
        
        self.offset = 1
        
        if FLXNetworkManager.shared.isConnectedToNetwork() {
            self.albums.removeAll()
            
            FLXNetworkManager.shared.getAlbums(
                offset: self.offset,
                pageSize: self.INITIAL_PAGE_SIZE,
                completion: { albums in
                    if let albums = albums {
                        for album in albums {
                            if let release = album.primaryRelease {
                                let displayObject = FLXAlbumDO(id: release.albumId ?? 0,
                                                               releaseCover: release.image ?? "",
                                                               releaseLabel: release.name ?? "")
                                self.albums.append(displayObject)
                            }
                        }
                        
                        self.offset += self.INITIAL_PAGE_SIZE
                        completion(self.albums)
                    }
                })
        }
        else {
            
        }
        
    }
    
    func pullUp(completion: @escaping ([FLXAlbumDO]) -> ()) {
        if FLXNetworkManager.shared.isConnectedToNetwork() {
            
            FLXNetworkManager.shared.getAlbums(
                offset: self.offset,
                pageSize: self.PAGE_SIZE,
                completion: { albums in
                    if let albums = albums {
                        for album in albums {
                            if let release = album.primaryRelease {
                                let displayObject = FLXAlbumDO(id: release.albumId ?? 0,
                                                               releaseCover: release.image ?? "",
                                                               releaseLabel: release.name ?? "")
                                self.albums.append(displayObject)
                            }
                        }
                        
                        self.offset += self.PAGE_SIZE
                        completion(self.albums)
                    }
                })
        }
        else {
            
        }
    }
    
}
