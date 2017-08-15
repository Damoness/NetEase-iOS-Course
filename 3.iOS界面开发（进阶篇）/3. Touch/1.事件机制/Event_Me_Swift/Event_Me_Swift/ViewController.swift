//
//  ViewController.swift
//  Event_Me_Swift
//
//  Created by 吴狄 on 2017/7/7.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.testHitTest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func testHitTest() {
        
        
        let testView = TestView(frame: CGRect(x: 40, y: 40, width: 50, height: 50))
        testView.backgroundColor = UIColor.black
        self.view.addSubview(testView)
        
        
        
    }

}

