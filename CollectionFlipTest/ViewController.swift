//
//  ViewController.swift
//  CollectionFlipTest
//
//  Created by flybywind on 15/12/19.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit
import CollectionFlip

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, FlyCollectionViewCellDelegate {

    @IBOutlet weak var imageCollection: UICollectionView!
    
    let collectionContent = [
        MyCellData(title: "estonia flag", imageName:"estonia"),
        MyCellData(title: "france flag", imageName:"france"),
        MyCellData(title: "germany flag", imageName:"germany"),
        MyCellData(title: "ireland flag", imageName: "ireland"),
        MyCellData(title: "italy flag", imageName: "italy"),
        MyCellData(title: "monaco flag", imageName: "monaco"),
        MyCellData(title: "nigeria flag", imageName:"nigeria"),
        MyCellData(title: "poland flag", imageName:"poland"),
        MyCellData(title: "russia flag", imageName:"russia"),
        MyCellData(title: "uk flag", imageName: "uk"),
    ]
    
    var allCells = [Int:MyCell]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageCollection.delegate = self
        imageCollection.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionContent.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        if let mycell = cell as? MyCell {
            let d = collectionContent[indexPath.item]
            mycell.image.image = UIImage(named: d.imageName)
            mycell.titleLabel.text = d.title
            mycell.delegateEffect = self
            mycell.config(5.0, tx: 50)
            allCells[indexPath.item] = mycell
            return mycell
        }
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let idx = indexPath.item
        let mycell = allCells[idx]
        
        mycell?.clicked()
    }
    
    func flip() {
        var done = 0
        for (_, c) in allCells {
            if !c.animFinished {
                return
            }
            done++
        }
        // all finished 
        assert(done == allCells.count)
        print("all effect finished, turn to another page")
    }
}

