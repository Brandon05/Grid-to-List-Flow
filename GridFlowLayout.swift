//
//  GridFlowLayout.swift
//  Grid to List Flow
//
//  Created by Brandon Sanchez on 1/29/17.
//  Copyright © 2017 Brandon Sanchez. All rights reserved.
//

import Foundation
import UIKit

class ProductsGridFlowLayout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout {
    
    // here you can define the height of each cell
    let itemHeight: CGFloat = 220
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 1pt distance between each cell and 1pt distance between each row plus use a vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
        sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    // here we define the width of each cell, creating a 2 column layout. In case you would create 3 columns, change the number 2 to 3
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width/2)-20
    }
    
//    override var estimatedItemSize: CGSize {
//        set {
//            self.itemSize = CGSize(width: itemWidth(), height: 1)
//        }
//        get {
//            return CGSize(width: itemWidth(), height: 1)
//        }
//    }
    
//* MARK:- Working Method
//    override var itemSize: CGSize {
//        set {
//            self.itemSize = CGSize(width: itemWidth(), height: itemHeight)
//        }
//        get {
//            return CGSize(width: itemWidth(), height: itemHeight)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView!.frame.width/2)-20
        
        let cell: PracticeCell1 = self.collectionView!.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! PracticeCell1
        
        cell.bounds = CGRect(x: 0, y: 0, width: itemWidth(), height: cell.bounds.height)
        cell.contentView.bounds = cell.bounds
        
        let size = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        
        return size
    }

    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
