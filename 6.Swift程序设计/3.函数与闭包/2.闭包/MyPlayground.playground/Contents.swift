//: Playground - noun: a place where people can play

import UIKit

var str = "闭包"


let names = ["zhao","Qian","Sun","Li","Zhou","Wu","Zheng","Wang"]



func comparator(s1:String,s2:String) -> Bool{
  
    return s1 < s2
    
}


names.sorted(by: comparator)


print(names)



