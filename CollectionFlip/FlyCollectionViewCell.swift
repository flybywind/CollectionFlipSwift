//
//  FlyCollectionViewCell.swift
//  CollectionFlip
//
//  Created by flybywind on 15/12/19.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

public protocol FlyCollectionViewCellDelegate {
    func flipStart()
    func flipEnd()
}


public class FlyCollectionViewCell: UICollectionViewCell {
    public var delegateEffect: FlyCollectionViewCellDelegate?
    public var anim_finish = false
    public var anim_start = false
    var duration: NSTimeInterval = NSTimeInterval(2)
    
    public func config(duration d: Double) {
        duration = NSTimeInterval(d)
        self.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        let width = self.frame.size.width
        let px = self.frame.origin.x
        let py = self.frame.origin.y
        self.frame.origin = CGPoint(x: px-width/2.0, y: py)
        self.layer.transform = CATransform3DIdentity
        self.alpha = 1
    }
    public func animating(initCell: Bool) {
        var random_delay: NSTimeInterval = 0
        anim_start = true
        if initCell {
            random_delay = 0
            self.delegateEffect?.flipStart()
        }else {
            random_delay = NSTimeInterval(arc4random_uniform(16))/32
        }
        let px = self.frame.origin.x
        let d = Double(px/self.frame.width + 1)
        // 创建动画
        UIView.animateWithDuration(self.duration*d, delay: random_delay, options: .CurveEaseOut,
            animations: {[unowned self] in
            var all_transform = CATransform3DIdentity
            // 增加perspective：
            all_transform.m34 = -1.0/500
            all_transform = CATransform3DTranslate(all_transform, -px, 0, px)
            all_transform = CATransform3DRotate(all_transform, CGFloat(-M_PI/2.2), 0, 1, 0)
            self.layer.transform = all_transform
            self.alpha = 0
            },
            completion: {[unowned self] _ in
                // 调用delegate
                self.anim_start = false
                self.anim_finish = true
                self.delegateEffect?.flipEnd()
        })
        
    }
}
