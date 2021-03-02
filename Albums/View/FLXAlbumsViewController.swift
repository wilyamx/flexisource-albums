//
//  FLXAlbumsViewController.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import UIKit

class FLXAlbumsViewController: FLXViewController {

    let PADDING: CGFloat = 10.0
    let COLUMNS: CGFloat = 3.0
    
    private lazy var viewModel = FLXAlbumsViewModel()
    
    @IBOutlet weak var colAlbums: UICollectionView!
    
    private var albums: [FLXAlbumDO] = [FLXAlbumDO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUI()
        self.getAlbums()
    }
    
    // MARK: - Private Methods
    
    private func initializeUI() {
        self.colAlbums.register(UINib.init(nibName: "FLXAlbumCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "FLXAlbumCollectionViewCell")
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: PADDING,
                                               left: PADDING,
                                               bottom: PADDING,
                                               right: PADDING)
        
        let width: CGFloat = (self.colAlbums.frame.width + (PADDING * (COLUMNS - 1))) / COLUMNS - (PADDING * COLUMNS)
        flowLayout.itemSize = CGSize(width: width, height: width)
        
        self.colAlbums.collectionViewLayout = flowLayout
        self.colAlbums.dataSource = self
        self.colAlbums.delegate = self
    }
    
    private func getAlbums() {
        self.viewModel.pullDown(
            completion: { albums in
                DispatchQueue.main.async {
                    self.albums = albums
                    
                    self.colAlbums.reloadData()
                }
            })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension FLXAlbumsViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.albums.count == 0 {
            //collectionView.setEmptyMessage(message: "no_results_available".localized())
        }
        else {
            //collectionView.restoreFromEmptyMessage()
        }
        return self.albums.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let data = self.albums[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "FLXAlbumCollectionViewCell",
            for: indexPath) as! FLXAlbumCollectionViewCell
        
        cell.configureViewCell(displayObject: data)
        
        return cell
    }
    
}

extension FLXAlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        
    }
}
