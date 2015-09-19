
import UIKit

func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let strData = NSString(data: inputData, encoding: NSUTF8StringEncoding)!
    return strData.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

var someString = input()

let myProgrammingSkill = 60
let myDatabaseSkill = 80
let mySkill = myProgrammingSkill + myDatabaseSkill / 2

//myProgrammingSkill += 10

// Data Types

let priceInferred = 19.99
let priceExplicit: Double = 19.99

let onSaleInferred = true
let onSaleExplicit: Bool = false

let nameInferred = "Whoopie Cushion"
let nameExplicit: String = "Whoopie Cushion"

// If statement with string interpolation

if onSaleInferred {
    print("\(nameInferred) on sale for \(priceInferred)!")
} else {
    print("\(nameInferred) at regular price: \(priceInferred)!")
}



