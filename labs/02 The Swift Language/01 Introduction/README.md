# Introduction to Swift

In this worksheet you will be learning about the Swift programming language. You will learn by reading and understanding some code, you will then be asked to modify the code. Finally you will be challenged to add some additional functionality.

## 1 Classes

Open the playground file `class and object.playground` and read through the code, using the comments to understand how it works. The code is split into two sections, a class plus some code that makes use of it. You should identify the following features:

1. the *private* instance variable `items`
2. the two initialisers, one of which takes a string array
3. the `addItem()` method that takes a single *String* parameter
4. the `getItem()` method. This either returns a *String* or throws an exception
5. the **guard** statement that throws an exception if the index is out of range

### 1.1 Documentation

Whenever you write your own code you should always fully document it. Properly documented code is understood by Xcode and is accessible in a couple of ways. Open the **Utilities Panel** and select the **Quick Help Inspector**. Now click on the class name on line 63 (you can turn on the line numbers in the **Xcode > Preferences** menu (**Text editing** tab). Notice that the formatted documentation appears in the panel.

Try clicking on the `addItem()` and `getItem()` methods to see the appropriate documentation.

Alternatively *alt-click* on any of these to see the documentation in a pop-over window.

### 1.2 Test Your Knowledge

Add a new method that returns the number of items in the list.

Add a method called `addUnique()` that only adds the new item if it does not already exist. It should return a `Todo.duplicateItem` exception if the item exists. HINT: look at the code snippet at the bottom of the script...

Add documentation to both of these methods and write code to test them.

### 1.3 Advanced Challenge
	
There is a **struct** defined at the top of the script. Modify the class so that it stores **Item** structs instead of **Strings**.

Remember to update the documentation!

## 2 Asynchronous Programming

We will be doing a lot of asynchronous work in our iOS apps. By using a **completion handler** we can run a block of code on completion of the async task. In this task you will be making an HTTP request. This needs to be done in its own thread otherwise the UI will freeze until the data has been returned.

You will be using the following foundation classes during the task. Take a moment to read through the documentation for each (shift+cmd+0):

1. NSURLSession
2. NSURL

Start by making the request in a web browser to see what data the API call will return. Open the Safari browser and enter the following URL. 

http://api.openweathermap.org/data/2.5/forecast/daily?units=metric&cnt=7&q=coventry,uk

Study the returned data carefully. If the data is not nicely formatted you will need to install the JSONView Extension which can be found at:

https://extensions.apple.com/details/?id=com.acrogenesis.jsonview-56Q494QF3L

Open the `weather.playground` file and read through the code carefully to understand how it works. You should identify the following features:

1. the *struct* at the top defining the data we will store for each daily forecast
2. the JSONError enum that enumerates the different errors (notice that one of these takes a *String* parameter
3. the **guard** statement that throws an error if it fails to unwrap the optional *NSURL* object.
4. the `dataTaskWithURL()` method that takes two parameters, an NSURL object and a completion handler (anonymous function). Study the syntax carefully...
5. the block of code in the **do** block matched to a series of **catch** blocks to handle any errors thrown.
6. the `for...in` loop that interates through the array.
7. a series of guard statements that unwrap AnyObject objects and cast them into suitable data types.

### 2.1 Tasks

1. Currently only the date and weather icon are being stored in the `Item` struct (as a UIImage). Modify the program to also store the description maximum temperature under the `description` and `maxTemp` fields in the struct. make sure you use guard statements and throw appropriate errors if the value is not available.
2. the wind speed and direction is supplied as an angle in degrees and a speed in mph. extract this data and add it to the struct.
3. take this data and use a switch statement to convert into a human-readable angle (eg. N, NW, S, etc). Add this data to the struct.

### 2.2 Test Your Knowledge

As an extension task you are required to retrieve and store the 24 hour forecast for every three hours. The API resource details can be found at: http://openweathermap.org/forecast5

## 3 Creating a Weather App

The final activity will consolidate your understanding of the basic Swift language.

Load the **Weather** Project into XCode

Read through the comments and make sure you understand how the code works.

- viewDidLoad (line 135)
- useSwifty (line 29)
- tableView cell for row at indexpath (line 164)

Now run the app and make sure it works correctly (pull to refesh the tableview). As the app runs study the **console** window. Try to work out what lines of code are generating the lines of output.

Try changing your device location. You could walk around the block but it would be difficult to see the console output without taking your computer! Luckily we can simulatr different locations using the **Simulate Location** button and choosing a location from the list.

![Choose Location](images/choose_location.png)

## Displaying Data in Table Cells

Carefully read the *Data Source* methods with the following signature:
```

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
```
Make sure you understand what its purpose is. In particular read through the documentation for the classes involved. You can do this by clicking on the string *NSDate* in the editor then opening the **Quick Help** inspector. There is a link at the bottom to take you to the full documentation:

1. UITableView
2. UITableViewCell
3. NSIndexPath
4. NSDate
5. NSDateFormatter

Currently only the date is showing in each cell. Open up the Storyboard, select the table cell and, in the attributed inspector change the style from **Basic** to **Right Detail**. Notice how in the cell-for-row-at-indexpath data source method only unwraps and sets the 

Use the existing code as a guide to unwrap the **detailTextLabel**. Display the date in this and, in the main **textLabel** display the weather description and max temperature using string interpolation (there are several examples of this in the code).

The date is only displayed as the day of the month. Modify the formatter's dateFormat string to display the day of the week, day of the month and month name, eg: **Mon Sept 21**. You may need to refer to the following web page:

http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/

## Displaying an Image

In this task you will be displaying a small image in each of the cells to summarise the weather for each day. You will be using two classes:

1. UIImage
2. UIImageView

Read through the documentation for these before continuing.

If you look carefully at the definition of our **Item** struct you will notice that the fourth key is called **icon** and stores a UIImage. Each cell has a built-in **UIImageView** which contains an **image** property. Based on the existing code, modify your app to display the correct weather icon in each UITableViewCell.

## Working with JSON Data

Most iPhone apps interact with online APIs to access useful information and to communicate with other users. In this next activity you will learn how to make GET requests over HTTP to download data in JSON format from an online API.

You will be making use of a number of important classes. Take a look at their documentation before you continue.

1. UIApplication
2. NSURLSession
3. NSURL
4. NSJSONSerialization

Locate the method `getForecast(withCity city: String) -> Void` located near the start of the `TableViewController.swift` file. Use the detailed comments to read through the code so that you understand how it works. Make sure you fully understand how the data is extracted safely from the json data.

### Test Your Knowledge.

The app already implements location services. You will modify the app to use the device's current location when displaying the weather. The **weather api** allows you to retrieve weather data based on a supplied latitude and longitude.
```
http://api.openweathermap.org/data/2.5/forecast/daily?lat=52.3&lon=-1.53&cnt=7
```
Read the documentation for the following classes:

1. CLLocationManager
2. CLLocationManagerDelegate
3. CLAuthorizationStatus

Study the code to understand the steps undertaken to display the current longitude and latitude in the console.

1. write a new method that takes a latitude and longitude to return weather data and store it in the array
2. call this method to update the weather each time the phone location changes
3. retrieve the location name and display this in the navigation bar


http://openweathermap.org/img/w/10d.png