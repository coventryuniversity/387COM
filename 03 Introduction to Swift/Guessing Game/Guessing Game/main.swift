
import Foundation

println("Guessing Game")

func randomIntBetween(low:Int, high:Int) -> Int {
    let range = high - (low - 1)
    return (Int(arc4random()) % range) + (low - 1)
}

func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    var inputStr = NSString(data: inputData, encoding:NSUTF8StringEncoding)
    println("raw input string \(inputStr)")
    if let data:String = inputStr as? String {
        println("string returned: \(data)")
        return data.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    return ""
}

let answer = randomIntBetween(0, 100)
var guess:Int?
var guessCount = 0

println(answer)
do {
    print("please input a number between 0 and 100: ")
    let userInput = input()
    println("user entered \(userInput)")
    guess = userInput.toInt()
    println("converted to int \(guess)")
    guessCount++
    if let attempt = guess {
        println("unwrapped optional: \(guess)")
        if guess > answer {
            println("lower")
        }
        else if guess < answer {
            println("higher")
        }
    }
} while guess != answer

println("correct, the answer was \(answer)")
println("you took \(guessCount) attempts")

