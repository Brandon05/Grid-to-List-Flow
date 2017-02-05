//
//  ViewController.swift
//  Grid to List Flow
//
//  Created by Brandon Sanchez on 1/29/17.
//  Copyright © 2017 Brandon Sanchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var isGridFlowLayoutUsed = true
    
// MARK:- Variables
    var gridFlowLayout = ProductsGridFlowLayout()
    var listFlowLayout = ProductsListFlowLayout()
    
    let cell1Nib = UINib(nibName: "PracticeCell1", bundle: nil)
    let cell2Nib = UINib(nibName: "PracticeCell2", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Must register nib to use them
        self.collectionView.register(cell1Nib, forCellWithReuseIdentifier: "cell")
        self.collectionView.register(cell2Nib, forCellWithReuseIdentifier: "cell2")
        
        setupInitialLayout() // collection view initializes blank, loadGridView causes autolayout loop onSwitch
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initialize default grid view
    func setupInitialLayout() {
        isGridFlowLayoutUsed = true
        collectionView.collectionViewLayout = gridFlowLayout
        if let flowLayout = self.collectionView.collectionViewLayout as? ProductsGridFlowLayout {
                flowLayout.estimatedItemSize = CGSize(width: (self.collectionView!.frame.width/2)-20, height: 1) //use auto layout for the collection view
        }
    }
    
// MARK: - Switch button between grid and list

    @IBAction func onSwitch(_ sender: Any) {
        
        self.collectionView.scrollToTop(animated: false, completion: {
    
           if(self.isGridFlowLayoutUsed){
            self.isGridFlowLayoutUsed = false
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.fadeOutGrid()
        } else {
            self.isGridFlowLayoutUsed = true
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.fadeOutList()
        }
        })
        
        
    }

// MARK:- CollectionViewFlowLayout Animations
    
    func fadeOutList() {
        let animationDuration = 0.5
        
        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.collectionView.alpha = 0
//            self.collectionView.scrollToTop(animated: false, completion: {
//            })
            //self.collectionView.scrollToTop(animated: true)
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
            self.collectionView.reloadData() {
                self.loadGridView() // must be called after new cells are loaded
            }
        }
    }
    
    func fadeOutGrid() {
        let animationDuration = 0.5
        
        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.collectionView.alpha = 0
//            self.collectionView.scrollToTop(animated: false, completion: {
//            })
        }) { (Bool) -> Void in
                self.collectionView.collectionViewLayout.invalidateLayout() //neccesary to avoid autolayout loop
            // After the animation completes, fade out the view after a delay
            self.collectionView.reloadData() {
                self.loadListView() // must be called after new cells are loaded
            }
        }

    }
        
// MARK: - UICollectionViewFlowLayout helpers
    func loadGridView() {
        
        UIView.animate(withDuration: 0, animations: { () -> Void in
            self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
            if let flowLayout = self.collectionView.collectionViewLayout as? ProductsGridFlowLayout {
                // Need to set estimatedSize to use autolayout
                flowLayout.estimatedItemSize = CGSize(width: (self.collectionView!.frame.width/2)-20, height: 100)
                self.collectionView.layoutIfNeeded()
            }
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 1, animations: { () -> Void in
                
                self.collectionView.alpha = 1
                UIApplication.shared.endIgnoringInteractionEvents()
            },
                           completion: nil)
        }

    }
    
    func loadListView() {
        
        UIView.animate(withDuration: 0, animations: { () -> Void in
            self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
            if let flowLayout = self.collectionView.collectionViewLayout as? ProductsListFlowLayout {
                // Need to set estimatedSize to use autolayout
                flowLayout.estimatedItemSize = CGSize(width: self.collectionView!.frame.width - 10, height: 1)
                self.collectionView.layoutIfNeeded()
            }
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 1, animations: { () -> Void in
                
                self.collectionView.alpha = 1
                UIApplication.shared.endIgnoringInteractionEvents()
            },
                           completion: nil)
        }
    }
}

// MARK: - UICollectionView Methods

extension ViewController {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        var identifier: String
        
        
        /*
         Determine the nib file to load
         - Returns: The cell loaded from its nib file.
         */
        if isGridFlowLayoutUsed == false {
            
            identifier = "cell2"
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PracticeCell2
            
            // Set width constraint
            let cellWidth = collectionView.frame.width - 10
            cell2.cellWidth.constant = collectionView.frame.width - 10

            cell = cell2
            

        } else {
            
            identifier = "cell"
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PracticeCell1
            
            // Set width constraint
            let cellWidth = (collectionView.frame.width/2) - 20
            cell1.cellWidth.constant = cellWidth
            
            cell = cell1
        }
//        collectionView.setNeedsLayout()
//        collectionView.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if let cell = PracticeCell1.fromNib() {
            cell.configureWithIndexPath(indexPath)
            cell.translatesAutoresizingMaskIntoConstraints = false
            
            return cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        }
        
        if let cell = PracticeCell2.fromNib() {
            cell.configureWithIndexPath(indexPath)
            cell.translatesAutoresizingMaskIntoConstraints = false
            
            return cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: self)
    }
}

/*
 Completion handler for reloadData()
 - collection view flow layout is set in completion
 */

extension UICollectionView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
    
    
}

extension UIScrollView {
    func scrollToTop(animated: Bool, completion: @escaping () -> Void) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        UIView.animate(withDuration: 0, animations: { self.setContentOffset(topOffset, animated: animated) })
        { _ in completion() }
    }
}

