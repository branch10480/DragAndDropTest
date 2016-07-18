//
//  PartsView.swift
//  DrDrTest2
//
//  Created by ImaedaToshiharu on 2016/06/03.
//  Copyright © 2016年 ImaedaToshiharu All rights reserved.
//

import UIKit

class PartsView: UIView {
    
    var initW:Int = 124
    var initH:Int = 44
    var initPos:CGPoint = CGPointZero
    var movable:Bool = false
    let scale:CGFloat = 1.3
    var dropped:Bool = false

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
     */
    
    // MARK: - Palette
    
    func toggleDragMode(dragModeOn:Bool) {
        if(dragModeOn) {
            // ドラッグ中デザイン
            if(CGAffineTransformIsIdentity(self.transform) && !dropped) {
                let t:CGAffineTransform = CGAffineTransformScale(self.transform, self.scale, self.scale)
                UIView.animateWithDuration(0.3, animations: {
                    self.transform = t
                })
            }
        } else {
            // 通常時デザイン
            UIView.animateWithDuration(0.3, animations: {
                self.transform = CGAffineTransformIdentity
            })
        }
    }
    
    // 初期位置に戻す
    func setInitialPos() {
        UIView.animateWithDuration(0.2, animations: {
            self.center = self.initPos
        })
    }
}
