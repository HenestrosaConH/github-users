//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by JC on 21/7/22.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
}
