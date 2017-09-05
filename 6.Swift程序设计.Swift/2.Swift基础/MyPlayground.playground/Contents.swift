//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

let result = Int8(12) + Int8(13)

let s = "ab \n cde \r"


s.characters.count


let testA = [1,2,3,4]

let testB =  [2,3,4,5,6]

let c = testA + testB

var dict: [String: String] = ["A":"hi", "B":"hello", "C":"Bye"]


var a = "a"
var b = "b"

var ab = a + b


//let singleLineString = "These are the same."
//let multilineString = """
//These are the same.
//"""

dict["A"] = nil

dict.count

var myTestSwift = "My Test Swift End"

print(myTestSwift.count)

var mySwift = myTestSwift.components(separatedBy: " ")


var numOfVowls = mySwift.map { (str) -> Int in
    
    
    var numOfVowel = 0;
    
    for ch in str.characters {
        
        if (ch == "A" || ch == "E" || ch == "I" || ch == "O" || ch == "U" || ch == "a" || ch == "e" || ch == "i" || ch == "o" || ch == "u") {
        
            numOfVowel+=1;
        }
        
    }
    
    return numOfVowel
    
}

print(numOfVowls)

let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
// 打印输出 "unusualMenagerie has 40 characters"



let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2


let exclamationMark: Character = "!"
welcome.append(exclamationMark)


let dogString = "Dog‼🐶"
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// 68 111 103 8252 55357 56374

let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面加上  ́
// eAcute 是 é, combinedEAcute 是 é

var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
// 打印输出 "the number of characters in cafe is 4"

word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.characters.count)")
// 打印输出 "the number of characters in café is 4"


var greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a

//greeting
greeting.indices

for index in greeting.indices{
    
    print(greeting[index])
}

greeting.index(after: greeting.startIndex);

greeting.insert("a", at: greeting.endIndex)

var prefix = greeting.prefix(3)

print(prefix)

for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}


