# Automated Testing

In this worksheet you will learn the principles of **test-driven development** through the creation of automated _unit tests_. This is an important skill for anyone who plans on a career in software development. Xcode has support for automated tests built-in and you will learn how to use these in an effective manner.

## Why Use Automated Tests?

Before we dive into this topic it is worth stepping back to understand _why_ we do this.

If we don't automate the testing process this needs to be carried out by the developer. This is time consuming and there is always the temptation to skip detailed testing in order to spend more time coding. By automating this process the tests are easy and quick to administer which means they are _more likely to be used_. As more functionality is added, additional tests can be added to the **testing suite** and _all the tests run every time_. This means that when a new feature is added the tests will run on the old code, highlighting if a bug has been introduced. This feature is called **regression testing** and is a powerful tool that means every line of code is tested every time the test suite is run.

There are two main types of test:

1. **Unit Tests** are designed to exhaustively tests each code _unit_. By this we typically mean each of the classes that makes up the app.
2. **User Interface Tests** (sometimes known as _acceptance tests_) are carried out on the user interface and are often agreed with the client.

In this worksheet you will learn about (and practice) writing and carrying out both types of test.

## 1 Unit Testing

Start by loading the **Notes** app. This should be familar from previous worksheets. Carry out the following steps:

1. 

Example using the Notes class and NoteSet singleton class.

Need to modify the target membership under file inspector to add both classes to the tests membership.

Can test View Controllers
http://www.iosmike.com/2014/08/unit-testing-viewcontrollers-in-swift.html

Sample working tests in the ToDo project covering testing View Controllers
Sample working tests in the Note Well project covering testing models (including singletons).

exercise based on adding book favourites (topic 3) to singleton. check for duplicates.
async method to return info on book from list via googleapis.
adding book id that doesnt exist.

Adding a test failure breakpoint

This breakpoint stops the execution when the test posts a failure assertion, helping to identify the point of failure.

###References
 https://developer.apple.com/library/prerelease/ios/documentation/DeveloperTools/Conceptual/testing_with_xcode/

http://natashatherobot.com/swift-2-xcode-7-unit-testing-access/

http://code.tutsplus.com/tutorials/advances-in-testing-with-xcode-7-and-swift-2--cms-24469

http://www.stephen-gurnett.org/unlikely-objects/2015/7/21/xcode-7-unit-test-coverage
