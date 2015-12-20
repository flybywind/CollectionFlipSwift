//
//  MyCell.swift
//  CollectionFlip
//
//  Created by flybywind on 15/12/19.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit
import CollectionFlip

class MyCell: FlyCollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}


struct MyCellData {
    var title:String
    var imageName: String
    
    init(title:String, imageName:String) {
        self.title = title
        self.imageName = imageName
    }
}