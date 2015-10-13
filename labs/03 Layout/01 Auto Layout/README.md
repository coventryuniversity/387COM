
# Worksheet

In this worksheet you will be learning about how to work with multi-page applications as well as applying the skills you learned in the previous topic.

Before you start remember to pull down any upstream changes.
```
git pull upstream master
```

## 1 Creating a Class Method

Open the **Books** project in XCode and run the project. Make sure you are comfortable with the existing functionality, paying particular attention to the data being printed to the *console* in XCode.. In particular notice that the title and id of the selected book are passed to the second view and the title is displayed. Try to answer the following questions:

1. how does the **search bar** connect to **SearchViewController**? What is the role of the `@IBOutlet`?
2. enter a search term and click on the search button on the keyboard. What methods get called?
3. study the `search()` method. How is the `Books.search()` method called? Trace the program flow to understand how the completion handler gets run.
4. open the storyboard, select each segue object and study its attributes.
5. how does the **segue** object allow data to be transferred from one view to another?

## 1.1 Test Your Knowledge

1. Modify the `Books.search()` method to include the book thumbnail as a *UIImage* and display these in the table cells.
2. The **book id** is being passed to the second view. Write a class method that passes this id to the API and returns the book details. An example URL is shown below.

https://www.googleapis.com/books/v1/volumes/mDzDBQAAQBAJ

You should return:

- the title
- the author(s)
- the publisher
- description
- ISBN
- an image of the book cover

You will need to define a new struct to hold this information. You should print this information to the console in `viewDidLoad()`

## 2 Creating an Adaptive Layout

To handle rendering controls on different screen sizes and orientations, Xcode makes use of **constraints**. Open the *document outline* and select the **Title Label**. Notice the blue icons indicating the different *constraints*.

These are the rules that the interface uses when deciding how to size and position the different elements on the screen. By selecting the label you will be shown visually the four constraints which are also listed in the *document outline*. If you select one of these you can view its properties in the **Attributes Inspector**.

1. select the title label to display its constraints
2. select the constraint that links it to the top layout guide. In the attributes inspector change its constant from 20 to 50. Notice how this modifies its position in the view.
3. drag the label down the view. Notice that this makes the top constraint invalid. There is additional information shown in orange, a dashed space showing where the constraints indicate the label should be and the constraint shows the difference in DPs.

![](images/dragging_label.png)

4. click on the **resolve Auto Layout Issues** button and choose **Update Frames**. The label frame changes to match the constraint.

![](images/resolve_auto_layout.png)

5. drag the label down again but this time choose **Update Constraints**. This changes the constraints to match the current label position.

6. drag a second label onto the view underneath the first and centre the text using the attributes inspector. Make it wider and then add four constraints.
  - ctrl-drag from the centre of the image up to the first label. Choose **vertical spacing** from the context-menu. This fixes the distance between the two labels.
  - ctrl-drag from the label centre left and choose **leading space to container margin**. This fixes the distance from the left margin of the view.
  - repeat to the right and choose **trailing space**.
  - finally ctrl-drag vertically *without leaving the bounds of the label frame* and choose **height**. These four contraints determine the position of the label.
7. To check the layout works correctly you should open the **assistant editor** and choose **Preview > Main Storyboard (Preview)**. You can add multiple screen sizes and rotate them to portrait or landscape to make sure your auto-layout works for all.

![](images/storyboard_preview.png)

### 2.1 Test Your Knowledge

Your next task is to display this information on the **detail view**. Use the **auto-layout** tools to produce a layout that works for both an iPhone 4S and an iPhone 6+. As you build your layout use the *Assistant Editor > Preview* tool to monitor how it looks.

## 3 Singletons

The file `Favourites.swift` contains a class that implements the **singleton** design pattern. This means that only one Favourites object can exist within the app. So how is this achieved? Read through the code carefully.

Notice that the initializer is *private* which prevents it from being called outside the class itself. Next note that **sharedInstance** is an immutable variable that points to an instance of *Favourites*. The first time this is called it initializes an instance of Favourites by calling its constructor. On subsequent calls the Favourites object already exists and so this is returned.

The class contains a *method* `addBook()` but also a **computed property** `bookList`. This is a property that is calculated at runtime. Notice that this is a *read-only* property (it only has a *getter*), to make it read and write you would add a **set** block to implement a *setter*.

Singletons are ideal for handing the application data. Whenever needed, the instance can be accessed and modified. Take a look at the `testSingleton()` method. Call this method in `viewDidLoad()` and run the app. Notice that despite retrieving the singleton twice and storing it it different variables all changes occur to the same object.

### 3.1 Test Your Knowledge

1. Implement a **computed property** that returns the number of items in the favourites list. Add code to the `testSingleton()` function to make sure it works.
2. Implement a method to return the book at a specified index (remember to use exception handling to deal with any indexes out of range)

## 4  Edit Actions

locate the delegate method `tableView:editActionsForRowAtIndexPath` in the `SearchViewController.swift` file.

Edit Actions are triggered by swiping left on a table cell. Run the app and swipe left. Click on the button that this action reveals. You will see an **activity view controller**, sometimes known as a *share sheet*. This displays various system options based on the objects passed in the **activityItems** array. For example if you passed a UIImage you would see additional options displayed. The options also include and social media accounts found on the device.

If you have an iPhone, install the app and view the share sheet.

### 4.1 Test Your Knowledge

1. Add a second edit action called **Add** which adds the book to the *Favourites* singleton. You can check this is working by printing out the `bookList` property each time a book is added.
2. You are already returning the book thumbnail as a UIImage. Pass this to the activity view controller as well as the book title. What extra options are now available in the share sheet?

## Presentation

https://goo.gl/M8xht4
