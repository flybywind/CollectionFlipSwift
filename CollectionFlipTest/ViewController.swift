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
    
    // mark: attribute
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
    var selectedCell = 0
    var flipDoneCnt = 0
    // mark: override func
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! DetailViewController
        dest.detailLabel.text = "you selected \(collectionContent[selectedCell].title)"
    }
    // mark: collection view
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
            mycell.config(duration: 0.3)
            allCells[indexPath.item] = mycell
            return mycell
        }
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let idx = indexPath.item
        let mycell = allCells[idx]
        selectedCell = idx
        mycell?.animating(true)
    }
    
    // mark: flip
    func flipStart() {
        for (_, c) in allCells {
            if !c.anim_start {
                c.animating(false)
            }
        }
        
    }
    func flipEnd() {
        flipDoneCnt++
        
        // all finished 
        if(flipDoneCnt == allCells.count){
            print("all effect finished, turn to another page")
            performSegueWithIdentifier("show", sender: self)
        }
    }
}

