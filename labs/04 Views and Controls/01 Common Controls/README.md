# Views and Controls
## Worksheet

In this worksheet we will learn about how to use **segues** to connect views and the differences between *modal* and *push* segues. You will also get a deeper understanding of the **application lifecycle** and the role of the `appDelegate.swift` file.

## 1 Application and View Controller Lifecycles

The **Application Delegate** performs actions on behalf of the overall app that is running. It handles app events such as the application loading and entering the background when you switch apps. This is a subclass of the UIResponder class and each app you create already has this defined in the `AppDelegate.swift` file. Open this up to understand the important events it can respond to.

Each of your custom view controllers is a subclass of UIViewController and this also defines a number of delegate methods that respond to their associated views being loaded, displayed, hidden, etc. Both the `ListViewController.swift` and `AddViewController.swift` files demonstrate a number of these. Read through these files to understand them.

Run the app and watch the console window to understand the sequence of these events. Use the add button to add a new note. Again, watch the sequence of events between the two view controllers.

## 2 Singleton Model

Study the class in `Notes.swift` and `ListViewController.swift`, notice:
1. this is a singleton (see previous worksheet)
2. it contains all the functionality required by the view controller
3. its instance is retrieved by the view controller each time it needs to interact with it
4. display a more human-readable date and time in the table cells

### 2.1 Test Your Knowledge

1. modify the view controller to allow notes to be deleted (see the **01 XCode** worksheet for more details)
2. add a mechanism to allow the order of the notes to be changed

## 3 Auto-Layout

Open the `AddViewController.swift` file. Read through the code carefully to understand how it works.

1. select the text view and use the *Attributes Inspector* to change the view background to a light gray.
2. run the app and click in the text view to open the keyboard, watch what happens to the text view size. How does the view know the size of the keyboard? How does it resize?
3. enter some text, watch the blue progress view bar as you type.
4. swipe down on the text view to dismiss the keyboard, watch the size of the text view. How does the swipe gesture trigger the keyboard removal?

### 3.1 Test Your Knowledge

1. remove the constraints from the textview.
2. add a **Text Field** between the progress view and the text view to store a note title (add a prompt). Set up the constraints on the text field and text view and make sure they work for different screen sizes and orientations.
3. create an outlet for this new text field `textField` and modify the **Notes** class so it will store the title and the note text.
4. change the table cell style to **Right Detail** and display both the note title and formatted creation date.

## 4 Views and Segues

You will now add another view controller to the app which will be used to view any notes.

1. Add a **View Controller** to the storyboard. Create a new subclass of *UIViewController* called `DisplayViewController` and in the **Identity Inspector** set this as the *custom class*.
2. Add two Labels and a TextView. Set the textview behaviour as non-editing in the *Attributes Inspector*.
3. Create outlets for all three views.
4. Create a public property called `note` to store the note details.
5. In the *ListViewController* control-drag from the prototype table cell to the new view controller and create a **push** segue called `viewSegue`.
6. add the `prepareForSegue()` method to pass the correct Notes object to the destination view
7. modify the `onLoad()` method to display the note details (date, title, content).

## 5 Editing Notes

Currently you can add, view and delete notes. In this final challenge you will modify the view screen to allow the note to be edited. For this to work you will need to add another method `updateNote()` and call this when the view closes. You will also need to make the textView *editable* and handle displaying and hiding the keyboard.

## Presentation

https://goo.gl/HzOTzp

## References

https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/TheAppLifeCycle/TheAppLifeCycle.html#//apple_ref/doc/uid/TP40007072-CH2-SW1

https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
