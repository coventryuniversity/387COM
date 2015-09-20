# Introduction to Swift


1. Parsing JSON Data with SwiftyJSON
2. Parsing JSON Data with Native Tools
3. Building a Custom Model Class
4. Building a Framework


Tasks

Load the Weather Project into XCode

Read through the comments and make sure you understand how the code works.

- viewDidLoad (line 135)
- useSwifty (line 29)
- tableView cell for row at indexpath (line 164)

Now run the app and make sure it works correctly (pull to refesh the tableview)

## Formatting the Cell

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


