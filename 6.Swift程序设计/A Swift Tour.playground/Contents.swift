//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


print("Hello,world!")

// Enumerations and Structures 枚举和结构

enum Rank:Int {
    case ace = 1
    case two,three,four,five,six,seven,eight,nine,ten
    case jack,queen,king
    
    func simpleDescription() ->String{
        switch self {
        case .ace:
        return "ace1"
        case .jack:
        return "jack"
        case .queen:
        return "queen"
        case .king:
        return "king"
        default:
        return String(self.rawValue)
        }
    }
    
    func  compareRaValue(rank:Rank) -> Bool{
        
        return self.rawValue == rank.rawValue;
        
    }
}

let ace = Rank.ace

print(ace.simpleDescription())

let aceRawValue = ace.rawValue

ace.compareRaValue(rank: Rank.queen)

if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

let rank = Rank(rawValue: 2)

//枚举的关联值是实际值，并不是原始值的另一种表达方法。实际上，如果没有比较有意义的原始值，你就不需要提供原始值。


