//
//  FlyCollectionViewCell.swift
//  CollectionFlip
//
//  Created by flybywind on 15/12/19.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

public protocol FlyCollectionViewCellDelegate {
    func flip()
}


public class FlyCollectionViewCell: UICollectionViewCell {
    public var delegateEffect: FlyCollectionViewCellDelegate?
    public var animFinished = false
    
    var duration: NSTimeInterval = NSTimeInterval(2)
    var transX: Double = 10

    
    public func config(d: Double, tx: Double) {
        duration = NSTimeInterval(d)
        transX = tx
    }
    public func clicked() {
        // 创建动画
        self.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        UIView.animateWithDuration(self.duration, animations: {[unowned self] in
            // 使用这种方法感觉像是先平移后旋转的！
            var translate = CATransform3DMakeTranslation(CGFloat(self.transX), 0, CGFloat(self.transX))
            // 增加perspective：居然是这样的
            translate.m34 = -0.005;
            let all_transform = CATransform3DRotate(translate, CGFloat(-M_PI/2), 0, 1, 0)
            self.layer.transform = all_transform
            self.alpha = 0
            }, completion: {[unowned self] _ in
                // 调用delegate
                self.delegateEffect?.flip()
        })
    }
}
