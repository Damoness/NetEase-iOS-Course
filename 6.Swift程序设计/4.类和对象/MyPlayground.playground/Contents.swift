//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Specification{
    var width :Double = 1004.2;
    var height:Double = 1032.4;
    var thickness:Double = 212.3;
    var listingDate = "2017-09-18"
    
    var volumn:Double{
        return width * height * thickness
    }
    
    init() {
        print("init")
    }
    
    
}

class TV{

    private var working = false;

    lazy var specification = Specification()
    
    func open(){
        self.working = true
    }
    
    func close(){
        self.working = false
    }
    
    var desciption:String{
        
        return "width :\(self.specification.width),height:\(self.specification.height),thickness:\(self.specification.thickness)"
        
    }

}

class GameTV:TV{
    
   override var desciption:String {
        return "GameTV: \(super.desciption)"
    }
}

var tv = TV()

tv.open()

tv.close()

tv.specification.volumn

//lazy 属性




