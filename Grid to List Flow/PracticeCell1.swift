//
//  PracticeCell1.swift
//  Grid to List Flow
//
//  Created by Brandon Sanchez on 1/29/17.
//  Copyright © 2017 Brandon Sanchez. All rights reserved.
//

import UIKit

class PracticeCell1: UICollectionViewCell {

    @IBOutlet var testView: UIView!
    @IBOutlet var cellWidth: NSLayoutConstraint!
    var width: Int?
//    var isHeightCalculated: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //forces the system to do one layout pass
//        let cellWidth = (UIScreen.main.bounds.width/2) - 20
//        print(cellWidth)
//        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cellWidth)
//        self.testView.activateConstraint(widthConstraint)
        
        
        
        
        //self.backgroundColor = UIColor.green
        //self.testView.translatesAutoresizingMaskIntoConstraints = false
        //self.autoresizesSubviews = true
        //self.preferredLayoutAttributesFitting(UICollectionViewLayoutAttributes)
    }
    
    /**
     Allows you to generate a cell without dequeueing one from a table view.
     - Returns: The cell loaded from its nib file.
     */
    class func fromNib() -> PracticeCell1?
    {
        var cell: PracticeCell1?
        let nibViews = Bundle.main.loadNibNamed("PracticeCell1", owner: nil, options: nil)
        for nibView in nibViews! {
            if let cellView = nibView as? PracticeCell1 {
                cell = cellView
            }
        }
        return cell
    }

    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        //Exhibit A - We need to cache our calculation to prevent a crash.
//        if !isHeightCalculated {
//            setNeedsLayout()
//            layoutIfNeeded()
//            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//            var newFrame = layoutAttributes.frame
//            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
//            layoutAttributes.frame = newFrame
//            isHeightCalculated = true
//        }
//        return layoutAttributes
//    }
    
    /**
     Sets the cell styles and content.
     */
    func configureWithIndexPath(_ indexPath: IndexPath)
    {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        //self.contentView.autoresizingMask = .flexibleWidth
//        let cellWidth = (UIScreen.main.bounds.width/2) - 20
//        print(cellWidth)
//        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cellWidth)
//        self.testView.addConstraint(widthConstraint)
        //label.text = labelTextWithNum(indexPath.item + 1)
        //label.preferredMaxLayoutWidth = 50
    }


}

extension PracticeCell1 {
//    class func fromNib() -> UICollectionViewCell?
//    {
//        var cell: UICollectionViewCell?
//        let nibViews = Bundle.main.loadNibNamed("PracticeCell1", owner: nil, options: nil)
//        for nibView in nibViews! {
//            if let cellView = nibView as? UICollectionViewCell {
//                cell = cellView
//            }
//        }
//        return cell
//    }
}
