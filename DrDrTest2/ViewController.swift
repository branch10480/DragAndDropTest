//
//  ViewController.swift
//  DrDrTest2
//
//  Created by ImaedaToshiharu on 2016/06/03.
//  Copyright © 2016年 ImaedaToshiharu All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dropZone: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func longPressed(sender: UILongPressGestureRecognizer) {
        let partsView:PartsView = sender.view as! PartsView
        if sender.state == .Began {
            partsView.toggleDragMode(true)
            partsView.movable = true
        } else if sender.state == .Ended {
            partsView.toggleDragMode(false)
        }
    }
    
    @IBAction func dragGesture(sender: UIPanGestureRecognizer) {
        let partsView:PartsView = sender.view as! PartsView
        
        // 移動可能状態で無いときは抜ける
        if !partsView.movable {return}
            
        if sender.state == .Began {
            
            NSLog("【Start】ドラッグが始まりました")
            
            // 初期位置を覚えさせる
            if partsView.initPos == CGPointZero {
                partsView.initPos = partsView.center
            }
            
            // レイヤーを一番上に持ってくる
            self.view .bringSubviewToFront(partsView)
        }
        
        let point:CGPoint = sender.translationInView(self.view)
        // 移動量をドラッグしたViewの中心値に加える
        let movePoint:CGPoint = CGPointMake((sender.view?.center.x)! + point.x, (sender.view?.center.y)! + point.y)
        sender.view?.center = movePoint
        // ドラッグで移動した距離を初期化する
        sender.setTranslation(CGPointZero, inView: self.view)
        
        if sender.state == .Ended ||
            sender.state == .Failed ||
            sender.state == .Cancelled {
            
            // ドロップゾーンの位置と大きさ
            let dropZoneRect:CGRect = self.dropZone.frame
            // ドラッグするためにタップしている座標を取得
            let dropPoint:CGPoint = sender.locationInView(self.view)
            
            if !CGRectContainsPoint(dropZoneRect, dropPoint) {
                // ドラッグオブジェクトがドロップゾーン以外にドロップされた場合、初期値に戻す
                UIView.animateWithDuration(0.3, animations: {
                    partsView.setInitialPos()
                })
                partsView.movable = false
                partsView.dropped = false
            } else {
                NSLog("正常にドロップされました")
                partsView.dropped = true
            }
        }
    }
    
    // リコグナイザーの同時検知を許可するメソッド
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func doubleTap(sender: UITapGestureRecognizer) {
        
        let partsView:PartsView = sender.view as! PartsView
        
        // 初期位置に戻す
        partsView.movable = false
        partsView.dropped = false
        partsView.setInitialPos()
    }
}

