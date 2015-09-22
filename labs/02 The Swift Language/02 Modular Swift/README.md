# Modular Swift

In this intermediate worksheet you will cover the following ways to separate the business logic **model** from the *controller* class:

1. building a class and instantiating multiple objects
2. building a class with **class** (static) methods
3. building a **singleton** and controlling shared access
4. building a custom **framework**
5. creating a **class extension**

## Introduction

In the previous worksheet you probably noticed that there was a lot of code in the *view controller class*, this included both code to handle interactions with the view but also a lot of code to handle business logic. This latter has no place in the controller file. In this worksheet you will learn a number of approaches to separating out this code making the app easier to maintain.

Whilst you can pass this module mixing all the code up in the controller you will need to separate it out if you are to get a higher grade in your assignment.

## 1 Classes and Objects

Locate and open the project in the **Weather with Object** folder and read through both the controller `TableViewController.swift` and the custom class `forecast.swift`. Make sure you understand how these work. There are comments in the code to help you. Any code re-used from the previous lab does not have detailed comments, refer to the previous lab if you are at all unsure about how it works.

In this app we instantiate a public Forecast object and then use this to populate the view.

## 2 Static Methods

Now locate and open the project in the **Singleton** folder. Again, read through the same files and identify how this version differs from the previous one. Instead of instantiating an object we use the class to call a static (class) method which returns the data. This is stored in a public array at the top of the controller class.

## 3 Singletons

You should now open the project in the **Singleton** folder. This demonstrates a third way to work with your model. Here the initialiser is private and accessed through a public `getInstance()` method. This checks to see if there in an instance of the class and if not it creates one and returns it. Future calls simply return the same object. In this way we can guarantee that there is only ever a single shared object. This is useful if we want to share the same model in different places in our app.

## 4 Framework

A further approach is to build our functionality into a separate project. This is called a **framework**. Once the functionality has been added to the framework this framework is added to any project requiring the functionality. This approach is obviously useful if you need the same functionality in more than one app.

Open the project in the **Framework** folder. Notice the **WeatherKit** framework that has been imported. Now open the project in the WeatherKit folder.

https://medium.com/@PyBaig/build-your-own-cocoa-touch-frameworks-in-swift-d4ea3d1f9ca3

## 5 Class Extensions

Finally we will work with **class extensions**. This is additional functionality attached to an existing class to extend its functionality. Open the project in the **Class Extension** folder.

http://www.swiftvideotutorials.com/creating-class-extensions
