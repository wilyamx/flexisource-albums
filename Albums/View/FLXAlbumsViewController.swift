//
//  FLXAlbumsViewController.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import UIKit

class FLXAlbumsViewController: FLXViewController {

    let PADDING: CGFloat = 8.0
    let COLUMNS: CGFloat = 3.0
    
    private lazy var viewModel = FLXAlbumsViewModel()
    
    @IBOutlet weak var colAlbums: UICollectionView!
    
    private var albums: [FLXAlbumDO] = [FLXAlbumDO]()
    private var isLoading = false
    
    private var footerView: FLXLoadingCollectionReusableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Albums"
        
        self.initializeUI()
        self.enableRefreshControl(scrollView: self.colAlbums)
        self.getAlbums()
    }
    
    // MARK: - Private Methods
    
    private func initializeUI() {
        self.colAlbums.register(UINib.init(nibName: "FLXAlbumCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "FLXAlbumCollectionViewCell")
        self.colAlbums.register(UINib.init(nibName: "FLXLoadingCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "FLXLoadingCollectionReusableView")
       
        self.colAlbums.backgroundColor = .white
        self.colAlbums.collectionViewLayout = UICollectionViewFlowLayout()
        self.colAlbums.dataSource = self
        self.colAlbums.delegate = self
    }
    
    private func alertForNoConnection() {
        FLXPopupManager.shared.popUpErrorDetails(
            presenter: self,
            title: "Alert",
            message: "No connection!")
    }
    
    private func getAlbums() {
        guard FLXNetworkManager.shared.isConnectedToNetwork() else {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                //self.alertForNoConnection()
            }
            return
        }
        guard !self.isLoading else { return }
        
        self.isLoading = true
        self.viewModel.pullDown(
            completion: { albums in
                DispatchQueue.main.async {
                    self.albums = albums
                    
                    self.refreshControl.endRefreshing()
                    self.colAlbums.reloadData()
                    self.isLoading = false
                }
            })
    }
    
    private func getNextAlbums() {
        guard FLXNetworkManager.shared.isConnectedToNetwork() else {
            DispatchQueue.main.async {
                self.isLoading = false
                self.colAlbums.reloadData()
            }
            return
        }
        guard !self.isLoading else { return }
        
        self.isLoading = true
        self.viewModel.pullUp(
            completion: { albums in
                DispatchQueue.main.async {
                    self.albums.append(contentsOf: albums)
                    
                    self.colAlbums.reloadData()
                    self.isLoading = false
                }
            })
    }
    // MARK: - Handlers
    
    override func refreshData(_ sender: Any) {
        self.getAlbums()
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
            self.colAlbums.setEmptyMessage("No results available")
        }
        else {
            self.colAlbums.restoreFromEmptyMessage()
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let loaderView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "FLXLoadingCollectionReusableView",
            for: indexPath) as! FLXLoadingCollectionReusableView
        self.footerView = loaderView
        return loaderView
    }
}

extension FLXAlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let data = self.albums[indexPath.row]
        DebugInfoKey.api.log(info: "selected an album \(data.id) at index \(indexPath.row) :: \(data.releaseCover)")
    }
}

extension FLXAlbumsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        let paddingSpace = PADDING * 4
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / COLUMNS

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: PADDING,
                            left: PADDING,
                            bottom: PADDING,
                            right: PADDING)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return PADDING
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return PADDING
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if self.albums.count == 0 || self.isLoading {
            return .zero
        }
        else {
            return CGSize(width: collectionView.frame.size.width, height: 50)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.actLoading.startAnimating()
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplayingSupplementaryView view: UICollectionReusableView,
        forElementOfKind elementKind: String,
        at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.actLoading.stopAnimating()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath) {
        
        if indexPath.row == self.albums.count - 1 && !self.isLoading {
            self.getNextAlbums()
        }
    }
}

