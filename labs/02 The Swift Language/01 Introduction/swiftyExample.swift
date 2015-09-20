/* here we define a private function that is not visible outside the class. It takes a single String parameter and returns nothing (Void). */
    private func useSwifty(withCity city: String) -> Void {
        /* to make it easier to follow this code, paste the following URL into a new browser tab. The 'let' keyword creates an 'immutable' variable (sometimes called a constant). Notice that the 'city' parameter is inserted into the string.*/
        let jsonUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&cnt=7&q=\(city)"
        /* to find out about the NSURLSession class, click on it then open the 'Quick Help' in the right-hand panel in XCode */
        let session = NSURLSession.sharedSession()
        let shotsUrl = NSURL(string: jsonUrl)
        //print(shotsUrl)
        /* This code creates a named task. There are two parameters here: the NSURL object and an anonymous function (callback). Take a few minutes to make sense of the syntax. The second (callback) parameter is between curly braces {}. It provides three parameters (data, response and error) and returns nothing (Void). */
        let task = session.dataTaskWithURL(shotsUrl!) { (data, response, error) -> Void in
            //print("dataTaskWithURL")
            do {
                /* the callback sends the response as an NSData object. We create a new JSON object passing the NSData object. This gives us a JSON object we can parse easily. */
                let json = JSON(data: data!)
                let days = json["list"]
                //print(days)
                /* 'days' is an array of JSON objects. We need to iterate through this to extract the forecast for each day. 'index' contains the array index (stored as a String) whilst 'element' is a JSON object. */
                for (index,element):(String, JSON) in days {
                    /* notice how we interpolate variables within a string. */
                    print("key: \(index)")
                    /* There is no guarantee that the JSON data contains the required key. If this is missing a 'nul' value is returned. If this is the case we need to stop and throw an error. We need to pass a string to this particular error */
                    guard let timestamp = element["dt"].double else {
                        throw JSONError.InvalidKey("day[\(index)].dt.double")
                    }
                    /* this next line does not use a guard statement. Can you fix it? */
                    let desc = element["weather"][0]["description"].stringValue
                    let icon = element["weather"][0]["icon"].stringValue
                    /* we need to turn the timestamp into an NSDate. The NSDate constructor requires an NSTimeInterval object. Open the utilities (right) pane on the **Quick Help** tab then try clicking on each class (in purple) to view the documentation */
                    let date = NSDate(timeIntervalSince1970: NSTimeInterval(timestamp))
                    /* now we create an 'Item' struct using the data from the JSON document. Notice that the 'maxTemp' value is extracted in-line. Add code to store this value in an immutable variable, throwing an error if it can't be found. */
                    let newDay = Item(date: date, description: desc, maxTemp: element["temp"]["max"].float!, icon: icon)
                    self.days.append(newDay)
                }
                //print(self.days)
                self.tableView.reloadData()
            } catch JSONError.InvalidKey(let message) {
                /* Here we catch a specific error. The message contains the string we passed when the error was thrown. */
                print("A JSON Key error has ocurred: \(message)")
            } catch is JSONError {
                /* this block of code will catch any JSONError */
            } catch {
                /* this block will catch any errors not caught by the previous blocks */
            }
        }
        task.resume()
        self.tableView.reloadData()
    }