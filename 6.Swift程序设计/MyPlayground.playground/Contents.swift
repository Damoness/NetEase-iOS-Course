//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let numbers = [1, 2, 3]
print(numbers.reduce(8){ 2 * $0 + $1})

let numbers1 = [1,2,3,4]

numbers1.filter { (a:Int) -> Bool in

    return a%2 == 0
}


numbers1.sorted { (a, b) -> Bool in
    return true;
}




func calculate(a : Int, b: Int, mathFunction:(Int, Int) -> Int) -> Int {
    return mathFunction(a, b)
}

calculate(a: 3, b: 5) { $0 + $1}


calculate(a:3, b: 5, mathFunction: {(a : Int, b : Int) -> Int in return a+b})


func sum(numbers: Int...) -> Int {
    var total: Int = 0
    for number in numbers {
        total += number
    }
    return total
}

sum(numbers: 1,2)



let galaxy = "Milky Way 🐮 你好"
for char in galaxy {
    print(char)
}

galaxy.count       // 11
galaxy.isEmpty     // false
galaxy.dropFirst() // "ilky Way 🐮"
String(galaxy.reversed()) // "🐮 yaW ykliM"

// Filter out any none ASCII characters
galaxy.filter { char in
    let isASCII = char.unicodeScalars.reduce(true, { $0 && $1.isASCII })
    return isASCII
} // "
