
# Worksheet

In this worksheet you will be learning about how to work with multi-page applications as well as applying the skills you learned in the previous topic.

## 1 Creating a Class Method

Open the **Books** project in XCode and run the project. Make sure you are comfortable with the existing functionality, paying particular attention to the data being printed to the *console* in XCode.. In particular notice that the title and id of the selected book are passed to the second view and the title is displayed. Try to answer the following questions:

1. how does the **search bar** connect to **SearchViewController**? What is the role of the `@IBOutlet`?
2. enter a search term and click on the search button on the keyboard. What methods get called?
3. study the `search()` method. How is the `Books.search()` method called? Trace the program flow to understand how the completion handler gets run.
4. open the storyboard, select each segue object and study its attributes.
5. how does the **segue** object allow data to be transferred from one view to another?

## 1.1 Test Your Knowledge

The **book id** is being passed to the second view. Write a class method that passes this id to the API and returns the book details. An example URL is shown below.

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
