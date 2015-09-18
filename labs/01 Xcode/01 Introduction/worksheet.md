# Introduction to XCode
## Worksheet

This lab is designed to take you through many of the key features of XCode which is the default Integrated Development Environment (IDE) for writing iOS apps. Don’t worry if you don’t understand many of the terms. Spend time finding your way around the XCode interface and ensure you understand the purpose behind the steps you carry out.

To complete this lab you will need to be running XCode 6 since we will be writing our code in the Swift programming language.

During this lab we will be building a shopping app called TODO which allows you to add and remove items from a shopping list at check items off as you buy them. All the graphical assets are available for you to use.

## Software Requirements

In order to complete this lab you will need access to a Mac computer running OS X 10.10 Yosemite and XCode 6. These are both free downloads from the Mac App Store.

## Regular Testing

The lab is broken down in a series of tasks. At the end of each task you should run your project in the simulator to ensure there are no build errors. The steps it takes you through are typical for all iOS projects.

So during this lab, make sure you remember to test everything after each step.

# Accessing the Teaching Materials

All the materials used in this module, both worksheets and sample code, are available through GitHub. The repository is located at `https://github.com/covcom/387COM`. You will need to clone this to your Mac before starting the labs. If you are comfortable doing this you can skip the rest of this section.

## Cloning the Material

This will require you to use the *Terminal* app, located in the `Application/Utilities` folder on your Mac. If you have ever used *Linux* most of the commands we use will be familiar since OSX is a UNIX variant. Open up the Terminal app and navigate to the Documents directory using `cd Documents`. You can then clone the entire repository using `git clone https://github.com/covcom/387COM` which will download the repository to the documents directory and checkout the latest files for you to work with. You should find a directory called 387OCOM. Inside this there is a directory for each lab.

## Committing Your Changes

Whilst you can freely clone the supplied repository you won't be able to commit any of your work back to it. You will need to create your own repository if you wish to do this. It is recommended that you create a repository on BitBucket[1]. Start by creating an account on their website (use your personal email address for this) and logging in.

### Registering an SSH Key on BitBucket

You will need to register a SSH key if you want to push changes to the remote repository. The first step is to make sure there is a key generated on your local computer. Open the terminal app and type in the following command. This will copy the computer’s public key to the clipboard.

```
ssh-keygen
pbcopy < ~/.ssh/id_rsa.pub
```
After logging in, access the *account settings* using the dropdown menu in the top-right corner of the screen.

![Accessing account settings](assets/01.png)

Make sure you add your photo and full name to this screen. Down the left-side of the screen there is a link to your SSH keys. Click on this to access the list of registered keys. You can now add your key by clicking on **Add Key** and pasting in the key from the clipboard. You will also need to add a label to this. If you are in the University lab you can use the unique machine ID on the sticker.

### Creating a New Repository

Return to the BitBucket home screen, click on the **Create** button at the top of the screen and choose *create a repository*. Give it the name *387COM* and make sure you choose the *Git* and not the *Mercurial* option. Choose the *Swift* language and then click on the **Create repository* button.

### Changing the Remote

You should be given the option to import an existing project. Clicking on the *I have an existing project* link should give you the commands you need to enter to push your local repository to your new remote. There is one change you will make to these instructions because you will already have a remote configured. See below for the detailed commands, remembering to substitute your repository URL where required.
```
git remote set-url origin git@bitbucket.org:[username]/387com.git
git push origin --all
git push origin --tags
```
You should now check on your BitBucket remote page that all commits are pushed.

### Pushing Changes
After completing an activity and before you leave the lab you need to make sure all local changes have been pushed to the remote. You will have already been taught this in previous modules so this should serve as a reminder.
```
git status
git add .
git status
git commit -m 'your commit message goes here'
git push origin master
```
Before logging off the Mac it is wise to check the BitBucket website to make sure your latest commit is safe.

### Working on a Different Mac
If you find yourself working on a different mac next lab session you will need to:

1. add the new Mac's public key
2. clone the repository to the new Mac

If you are using more than one Mac you should pull all changes from BitBucket before starting any work.
```
git pull
```
You are now ready to start learning iPhone Development.

## Opening the Project

Use *Finder* to open the Documents directory where you will find a directory called 387COM. If you open this you should be able to navigate to the files for this first lab. Locate the `ToDo.xcodeproj` file and double-click on this to open the project.

## Building the User Interface

The first step is to build our interface (or view) as a storyboard. This is stored in a file called Main.storyboard and contains any views we want to use in the app. Open this file and check that the bar at the bottom of the screen is grey, not blue.

![Views in the Storyboard](assets/views.png)

Lets take a moment to understand what the storyboard contains. On the left we have a Navigation controller. This is a container that holds the different views that form our app. its is the navigation controller that displays the name of the view and the back button to the previous view if required.

On the right you can see a table view. This, as its name implies allows us to display a table (list) of items. The arrow joining the two is called a segue and the symbol in the circle indicated that the table view is a *root view* which means it can never be removed.

The arrow on the far left pointing to the navigation controller is called the *entry point* and indicated which view should be loaded when the application first runs.

## Prototype Cells



In our table view you can see a single table cell labelled a prototype cell. As we add rows to our table, this cell gets duplicated as many times as required to hold the information. At the moment it is blank however we need it to contain a label to hold the names of the items in our shopping list.

Open the document outline (by clicking on the indicated button in the grey status bar shown above) and select the Table View Cell (as shown).





Open the Attribute Inspector in the right pane and use the Style dropdown to select the Basic style. This will add a single label to the prototype cell.



We also need to give this prototype cell an identifier which we can use to refer to it in our code. Lets assign the identifier ShoppingItem.




The bar along the top of the screen is called a Navigation Bar. We need to At the moment the storyboard is showing a simulated bar, we need to drag a NavigationItem object onto the table view.


Now you can double click to change the label on the nav bar to show the name of our app.

## View Controllers

Each view requires a matching controller which contains the code that is needed to handle user interactions. Since we have deleted a view and added a different view we need to delete the existing view controller and add a new one. In the Project Navigator locate the file called ViewController.swift right click on it and delete it.





We now need to add a new controller file. This will be a subclass of UITableViewController. Start by right-clicking on the ToDo folder in the Project Navigator and choosing New File from the context menu.

Locate the Cocoa Touch class option and choose Next.
Call it ListController and use the drop-down list to make it a subclass of UITableViewController.




The final task is to connect it to the Table View in the storyboard. Open the Storyboard and select the root view controller in the document outline.

Open the Identity Inspector and use the Class dropdown in the Custom Class section to choose your new view controller.

Test your app now. Choose IPhone 4S.





## Populating the ListView

In this task we will learn how the list view displays data and use this knowledge to display some placeholder text.

Open up the ListController.swift controller file and locate these three methods (functions). The first tells the controller how many table sections there will be. The second takes a section number and many table cells in each section and the third takes an indexpath (which contains a section and a row value and returns the tableview cell containing the appropriate information. Take a few minutes to familiarise yourself with the syntax, in particular identify the names of the methods, the parameters and the return type.

We want to have a single section with 5 rows in it. In each cell we want to display the string “Hello World”. To achieve this we modify our methods as shown.


We return 1 from the first method to define one section, 5 from the second method which defines 5 rows of data and in the third method we insert our cell identifier ShoppingItem so it uses that prototype cell and set the text property of the textLabel control to the string “Hello World”. If we run our app we should see 5 table cells, each containing the same string.

## Loading Data From an Array

Whilst it was a good test to make sure the three table view data source methods were working  correctly, displaying the same text in each cell doesn’t make a particularly good to do list! Computers use a data structure called an array to store lists of items so we will modify our code to create an array, add items to it and use this data in our table view.

At the top of your ShoppingController class, declare an array object. This is placed just under the class declaration and before the viewDidLoad method. Because it has been declared outside any methods it has global scope (it can be accessed by any method in this class.

Lets analyse the syntax we used. The var keyword tells us we are declaring a variable. The name of the variable is items and it will hold an array of strings (the square brackets denote an array). It will be assigned two values, Bread and Butter.

We now need to modify two of our data source methods. The number of rows will depend on the number of strings in the array (retrieved using the .count property) and the string in each cell is stored in the appropriate array index.

Hint:  Use tab to finish off syntax (Auto Complete), saves time and a lot of typing!

The indexPath variable contains both a section and a row property. We are using the row property.

If we run our app now we should see the two items appearing in our table view.

Hint: Remember you need to change the override func tableView as we don’t need 5 cells, we need enough cells to display the items in the array.
Using the Version Editor
Its time to return to the version control built into XCode.

Before you do your next commit, make sure your app runs by testing it in the simulator.

Start by viewing the ListController.swift file. Once this is open click on the Version Editor button in the toolbar.

What you are seeing are the changes made to the file since the last commit. It shows any lines of code added, deleted or modified. Any changes can be discarded before the changes are committed. The version on the left is the current version whilst the one on the right is from the last commit.

Since your app runs correctly you should commit these changes and add a suitable message such as ‘Loading data from an array’

From this point onwards you should commit at the end of each section of this walkthrough. Use the section titles as the commit messages.

## Adding a Button with IBAction

An important feature is to allow users to add new items to the list. We will achieve this by adding a button to the navigation bar. When the user clicks this it will display a dialog box on the screen. During this task we will learn about how we use IBActions to detect user interaction in the view and run a block of code in the view controller.

Start by opening the storyboard and finding the Bar Button Item in the Object Library. Drag this to the right hand side of the navigation bar.



Make sure this is selected in the Document Outline.



In the Attributes Inspector change its Identifier to Add.

In the toolbar click on the Assistant Editor button to display both the storyboard and the view controller.
  
Hold down the ctrl key and drag from the Bar Button Item into the View Controller as shown.

A dialog box will appear. Choose the Action connection, give the action a suitable name and specify the UIBarButtonItem object Type will trigger it.  Click on Connect.

This will add a new method that has a special @IBAction keyword in front of it. Any code you add here will run when the Bar Button Item is clicked. 
Add the following NSLog function call which will display a message in the system log (at the bottom of the XCode window) when it is run.

Run your app and try pressing the button a few time. What happens?
Hint:  We know the button is working, how?
Hint: Look at the Output window in Xcode.
Displaying a Dialog Box

Now we have a button to click with an NSAction to run we can add code to display our dialog box. Dialog boxes are instances of the UIAlertController class so the first step is to create one of these and display it on-screen.
Start by creating a UIAlertController and instantiating it. We can then call the presentViewController, passing our controller which will display it on the screen. Unfortunately since there are no buttons we can’t dismiss it!


Lets add an action to the alert which will add a button. We specify a title and a method that will be called when the button has been clicked. We will also need to add this method.

If we run our app now we will see a button. When this is clicked the dialog will close the the log message ‘itemAdded’ will be displayed in the output window in XCode.
 

The final step is to add a text box so the user can type in a new item to add to the list. The text box is called a UITextField and we need to create a global UITextField outlet in our code to store the value. This needs to be declared at the top of our view controller class.
Next we call the addTextFieldWithConfigurationHandler method for our UIAlertController object and pass it a method to bind (connect) the alert field with the IBOutlet we created. We will also have to create the method.

## Adding Items to the Array

Our final step is to take the item entered into the Dialog box and add it to the array. If we then refresh the table view the item should appear on the phone screen.

We will be adding code to the method that is called when the button on the dialog box is pressed. lets start by adding a log message that displays the string entered in the dialog box.

If we run this app you should see the string you enter in the dialog box displayed in the system log.

Next we will append the new string to the end of the array and print the array to the system log to make sure it has been added.

Run the app to make sure this is working

The final step is to refresh the Table View. This forces the table view to reload the data from the array, which now includes our extra string.



If we run our app you will see that you can now add extra items to the list.
