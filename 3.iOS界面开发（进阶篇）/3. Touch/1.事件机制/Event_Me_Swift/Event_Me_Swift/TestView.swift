//
//  TestView.swift
//  Event_Me_Swift
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

import UIKit

class TestView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    public var name:String = "";
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        
        //NSLog("hit test from \(self.name)");
        
        
        let hitView = super.hitTest(point, with: event)
        
        //print("return hit view \(String(describing: hitView)),self: \(self)")
        
        return hitView;

    }
    
    
    override var description: String{
        
         return   "[TestView \(self.name)]";
        
    }

}
