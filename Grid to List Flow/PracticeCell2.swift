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
        
    }
    
    override func prepareForReuse() {
        //super.prepareForReuse()
        //Not sure why: stops autolayout loop
    }
    
    /*
     Allows you to generate a cell without dequeueing one from a table view.
     - Returns: The cell loaded from its nib file.
     */
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
    
    /*
     Configure data from model and set style
     */
    func configureWithIndexPath(_ indexPath: IndexPath) {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    }

}
