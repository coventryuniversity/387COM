import Foundation

func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    var inputStr = NSString(data: inputData, encoding:NSUTF8StringEncoding)
    if let data:String = inputStr as? String {
        return data.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    return ""
}

print("please input a town or city: ")
let city = input()
println("city entered was '\(city)'")

let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?units=metric&q=\(city)")
println(url)
let queue:NSOperationQueue = NSOperationQueue()
var request = NSURLRequest(URL: url!)
println("request complete: \(request)")
NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
    println("completion handler called")
    var json = JSON(data: data!)
    println(json)
    if let name = json["name"].string {
        println("name: \(name)")
    }
    if let dt = json["dt"].int {
        println(dt)
    }
    if let temp = json["main"]["temp"].float {
        println("temperature \(temp)")
    }
})

