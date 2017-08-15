//
//  BookScanView.swift
//  BookCollection
//
//  Created by 吴狄 on 2017/8/10.
//  Copyright © 2017年 SharePlus. All rights reserved.
//

import UIKit

class BookScanView: UIView {



    var rectSize:CGSize;
    var offsetY:CGFloat;

    
    
    
    class Food {
        var name: String
        init(name: String) {
            self.name = name
        }
        convenience init() {
            self.init(name: "[Unnamed]")
        }
    }
    
    class RecipeIngredient: Food {
        var quantity: Int
        init(name: String, quantity: Int) {
            self.quantity = quantity
            super.init(name: name)
        }
        override convenience init(name: String) {
            self.init(name: name, quantity: 1)
        }
    }
    
    
    class ShoppingListItem: RecipeIngredient {
        var purchased = false
        var description: String {
            var output = "\(quantity) x \(name)"
            output += purchased ? " ✔" : " ✘"
            return output
        }
    }
    
    var  s = ShoppingListItem();
    
    
    init(frame:CGRect,rectSize:CGSize,offsetY:CGFloat){
        
        self.rectSize = rectSize;
        self.offsetY = offsetY;
        
        super.init(frame: frame)
        
        

    }

    
    convenience override init(frame:CGRect){
        self.init(frame: frame, rectSize: CGSize(width: 100, height: 100), offsetY: 100);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        

    }
    

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code

        let context = UIGraphicsGetCurrentContext()!;
        
        context.setFillColor(red: 0, green: 0, blue: 0, alpha: 0.4);
        
        
        //context.fill(<#T##rect: CGRect##CGRect#>)
        

        let wholeNumber: Double = 12345.0
        let pi = 3.14159
        
        if let valueMaintained = Int(exactly: wholeNumber) {
            print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
        }
        // Prints "12345.0 conversion to Int maintains value of 12345"
        
        let valueChanged = Int(exactly: pi)
        // valueChanged is of type Int?, not Int
        
        if valueChanged == nil {
            print("\(pi) conversion to Int does not maintain value")
        }
        
        
    }
    
    

}
