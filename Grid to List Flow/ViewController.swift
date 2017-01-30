//
//  ViewController.swift
//  Grid to List Flow
//
//  Created by Brandon Sanchez on 1/29/17.
//  Copyright © 2017 Brandon Sanchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

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
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.collectionView.register(cell1Nib, forCellWithReuseIdentifier: "cell1")
        self.collectionView.register(cell2Nib, forCellWithReuseIdentifier: "cell2")
        
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
    }
    
// MARK: - Switch button between grid and list

    @IBAction func onSwitch(_ sender: Any) {
        
        if(self.isGridFlowLayoutUsed){
            self.isGridFlowLayoutUsed = false
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
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
            self.collectionView.reloadData() {
                self.loadListView()
                UIView.animate(withDuration: 1, animations: { () -> Void in
                    self.collectionView.alpha = 1
                    
                },
                               completion: nil)
            }
        }

    }
        
// MARK: - UICollectionViewFlowLayout helpers
    func loadGridView() {
        
        UIView.animate(withDuration: 0) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
        }
    }
    
    func loadListView() {
            
            UIView.animate(withDuration: 0) { () -> Void in
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
            }
        }
}

// MARK: - UICollectionViewDataSource

extension ViewController {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        var identifier: String
        
        if isGridFlowLayoutUsed == false {
            
            identifier = "cell2"
            
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PracticeCell2

            cell = cell2

        } else {
            
            identifier = "cell1"
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PracticeCell1
            
            cell = cell1
            
        }
        
        return cell
    }
}

// Completion handler extension for reload data

extension UICollectionView {
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}

