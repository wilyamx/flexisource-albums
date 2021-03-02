//
//  FLXViewController.swift
//  Albums
//
//  Created by William S. Rena on 3/2/21.
//  Copyright © 2021 Flexisource IT. All rights reserved.
//

import Foundation
import UIKit

class FLXViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public Methods
    
    func enableRefreshControl(scrollView: UIScrollView) {
        if #available(iOS 10.0, *) {
            scrollView.refreshControl = refreshControl
        }
        else {
            scrollView.addSubview(refreshControl)
        }
        self.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        let color = UIColor.lightGray
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        self.refreshControl.tintColor = color
        self.refreshControl.attributedTitle = NSAttributedString(string: "Initializing Data ...", attributes: attributes)
    }
    
    // MARK: - Handlers
    
    @objc func refreshData(_ sender: Any) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }

    }
}
