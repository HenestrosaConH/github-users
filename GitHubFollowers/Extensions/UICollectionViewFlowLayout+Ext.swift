//
//  UICollectionViewFlowLayout+Ext.swift
//  GitHubFollowers
//
//  Created by JC on 29/6/22.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    static func createColumnFlowLayout(of columns: Int, in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        
        // padding * 2 -> because the padding is present on the left and right of the screen
        // minimumItemSpacing * (columns - 1) -> number of spaces between each cell (without counting the left and right padding with the screen).
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * CGFloat((columns - 1)))
        let itemWidth = availableWidth / CGFloat(columns)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        // 40 gives the cell extra space for the label
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
