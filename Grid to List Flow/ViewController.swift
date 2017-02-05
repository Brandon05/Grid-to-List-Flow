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
    
    var gridFlowLayout = ProductsGridFlowLayout()
    var listFlowLayout = ProductsListFlowLayout()
    
    let cell1Nib = UINib(nibName: "PracticeCell1", bundle: nil)
    let cell2Nib = UINib(nibName: "PracticeCell2", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionView.register(cell1Nib, forCellWithReuseIdentifier: "cell")
        self.collectionView.register(cell2Nib, forCellWithReuseIdentifier: "cell2")
        
        
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10) //could not set in storyboard, don't know why
//            flowLayout.estimatedItemSize = CGSize(width: 1, height:1)
//        }
        //fadeOutList()
        //loadGridView()
        setupInitialLayout()
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
        
        if(self.isGridFlowLayoutUsed){
            self.isGridFlowLayoutUsed = false
            UIApplication.shared.beginIgnoringInteractionEvents()
            fadeOutGrid()
//            UIView.transition(with: collectionView,
//                              duration: 1,
//                              options: .transitionCurlDown,
//                              animations:
//                { () -> Void in
//                    self.collectionView.reloadData() {
//                            self.loadListView()
//                    }
//            },
//                              completion: nil);
            
        } else {
            self.isGridFlowLayoutUsed = true
            fadeOutList()
            UIApplication.shared.beginIgnoringInteractionEvents()
//            UIView.transition(with: collectionView,
//                              duration: 1,
//                              options: .transitionCurlUp,
//                              animations:
//                { () -> Void in
//                    self.collectionView.reloadData() {
//                        self.loadGridView()
//                    }
//            },
//                              completion: nil);
            
        }
        
        

//        collectionView.reloadData() {
//            print("here")
//            if(!self.isGridFlowLayoutUsed){
//            self.loadListView()
//            //self.isGridFlowLayoutUsed = true
//            } else {
//            self.loadGridView()
//            //self.isGridFlowLayoutUsed = false
//            }
//        }
    }

    
    func fadeOutList() {
        let animationDuration = 0.5
        
        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.collectionView.alpha = 0
            
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
            self.collectionView.reloadData() {
                self.loadGridView()
            UIView.animate(withDuration: 1, animations: { () -> Void in
                self.collectionView.alpha = 1
                UIApplication.shared.endIgnoringInteractionEvents()
            },
                                       completion: nil)
            }
        }
    }
    
    func fadeOutGrid() {
        let animationDuration = 0.5
        
        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            self.collectionView.alpha = 0
            //
        }) { (Bool) -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout() //neccesary to avoid autolayout loop
            // After the animation completes, fade out the view after a delay
            self.collectionView.reloadData() {
                self.loadListView()
//                UIView.animate(withDuration: 1, animations: { () -> Void in
//                    self.collectionView.layoutIfNeeded()
//                    self.collectionView.alpha = 1
//                    
//                },
//                               completion: nil)
            }
        }

    }
        
// MARK: - UICollectionViewFlowLayout helpers
    func loadGridView() {
        
//        UIView.animate(withDuration: 0) { () -> Void in
//            self.collectionView.collectionViewLayout.invalidateLayout()
//            self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
//            if let flowLayout = self.collectionView.collectionViewLayout as? ProductsGridFlowLayout {
//                flowLayout.estimatedItemSize = CGSize(width: (self.collectionView!.frame.width/2)-20, height: 100) //use auto layout for the collection view
//            }
//        }
        
        UIView.animate(withDuration: 0, animations: { () -> Void in
            self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
            if let flowLayout = self.collectionView.collectionViewLayout as? ProductsGridFlowLayout {
                flowLayout.estimatedItemSize = CGSize(width: (self.collectionView!.frame.width/2)-20, height: 100)//use auto layout for the collection view
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
            
//            UIView.animate(withDuration: 0) { () -> Void in
//                //self.collectionView.collectionViewLayout.invalidateLayout()
//                self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
//                if let flowLayout = self.collectionView.collectionViewLayout as? ProductsListFlowLayout {
//                    flowLayout.estimatedItemSize = CGSize(width: self.collectionView!.frame.width - 10, height: 1) //use auto layout for the collection view
//                }
        
        UIView.animate(withDuration: 0, animations: { () -> Void in
            self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
            if let flowLayout = self.collectionView.collectionViewLayout as? ProductsListFlowLayout {
                flowLayout.estimatedItemSize = CGSize(width: self.collectionView!.frame.width - 10, height: 1)//use auto layout for the collection view
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

// MARK: - UICollectionViewDataSource

extension ViewController {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        var identifier: String
        
        if isGridFlowLayoutUsed == false {
            
            identifier = "cell2"
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PracticeCell2
//            cell2.cellWidth = NSLayoutConstraint(item: cell2, attribute: .width, relatedBy: .equal, toItem: collectionView, attribute: .width, multiplier: 1.0, constant: 300)
            let cellWidth = collectionView.frame.width - 10
            cell2.cellWidth.constant = collectionView.frame.width - 10
            //cell2.translatesAutoresizingMaskIntoConstraints = false
//            print(cellWidth)
//            let widthConstraint = NSLayoutConstraint(item: cell2, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cellWidth)
//            cell2.addConstraint(widthConstraint)
            cell = cell2
            

        } else {
            
            identifier = "cell"
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PracticeCell1
            //cell1.configureWithIndexPath(indexPath)
//            cell1.cellWidth = NSLayoutConstraint(item: cell1, attribute: .width, relatedBy: .equal, toItem: collectionView, attribute: .width, multiplier: 1.0, constant: 300)
            let cellWidth = (collectionView.frame.width/2) - 20
            cell1.cellWidth.constant = cellWidth
            print(cellWidth)
            //cell1.translatesAutoresizingMaskIntoConstraints = false
            
            //let widthConstraint = NSLayoutConstraint(item: cell1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cellWidth)
            //cell1.translatesAutoresizingMaskIntoConstraints = false
            //cell1.testView.addConstraint(widthConstraint)
            //cell1.widthAnchor.constraint(equalToConstant: cellWidth)
            cell = cell1
            //return cell1
        }
//        collectionView.setNeedsLayout()
//        collectionView.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width = (self.collectionView!.frame.width/2)-20
        
//        let cell: PracticeCell1 = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! PracticeCell1
        if let cell = PracticeCell1.fromNib() {
//        cell.bounds = CGRect(x: 0, y: 0, width: width, height: cell.bounds.height)
//        cell.contentView.bounds = cell.bounds
        cell.configureWithIndexPath(indexPath)
        cell.translatesAutoresizingMaskIntoConstraints = false
        
            
        return cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        }
        
        if let cell = PracticeCell2.fromNib() {
            //        cell.bounds = CGRect(x: 0, y: 0, width: width, height: cell.bounds.height)
            //        cell.contentView.bounds = cell.bounds
            cell.configureWithIndexPath(indexPath)
            cell.translatesAutoresizingMaskIntoConstraints = false
            
            return cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        }
        
        return CGSize.zero
    }
}

// Completion handler extension for reload data

extension UICollectionView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
    
    
}

