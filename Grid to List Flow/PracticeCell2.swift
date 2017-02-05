//
//  PracticeCell2.swift
//  Grid to List Flow
//
//  Created by Brandon Sanchez on 1/29/17.
//  Copyright © 2017 Brandon Sanchez. All rights reserved.
//

import UIKit

class PracticeCell2: UICollectionViewCell {

    @IBOutlet var cellWidth: NSLayoutConstraint!
    @IBOutlet var testView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.red
        self.contentView.autoresizingMask = .flexibleWidth
        //self.translatesAutoresizingMaskIntoConstraints = false
        //cellWidth = NSLayoutConstraint(item: testView, attribute: .width, relatedBy: .equal, toItem: superview, attribute: .width, multiplier: 1, constant: 5)
    }
    
    override func prepareForReuse() {
        //self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    class func fromNib() -> PracticeCell2?
    {
        var cell: PracticeCell2?
        let nibViews = Bundle.main.loadNibNamed("PracticeCell2", owner: nil, options: nil)
        for nibView in nibViews! {
            if let cellView = nibView as? PracticeCell2 {
                cell = cellView
            }
        }
        return cell
    }
    
    func configureWithIndexPath(_ indexPath: IndexPath)
    {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        //self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let cellWidth = UIScreen.main.bounds.width - 10
        print(cellWidth)
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cellWidth)
        //self.contentView.addConstraint(widthConstraint)
        //label.text = labelTextWithNum(indexPath.item + 1)
        //label.preferredMaxLayoutWidth = 50
    }

}
