# Frameworks
## Worksheet

In this worksheet you will be developing apps for third-party wearables. During this process you will learn about.

1. Integrating third-party frameworks into your apps
2. Building bridging header files to allow you to use Objective-C libraries in your Swift programming

You will be developing apps that connect to and make use of the features of the **Microsoft Band**. The exercises cannot run on a simulator, you need to use an iOS device running the latest version of iOS and connected to a *Microsoft Band* via Bluetooth. Specifically you will learn how to:

1. Access the data from the accelerometer and gyroscope
2. Communicate with the wearer using haptic feedback

You should already understand the following:

1. the syntax of **closures** in Swift
2. implementing **protocols**
3. local notifications

## Sample Code

There are a number of sample projects that demonstrate the underlying principles. These were originally supplied by Microsoft written in Objective-C and have been converted to run in Swift. You may use this code in your projects but must copy and paste the header comments to give credit to the authors.

1. **BandSensor**: demonstrates how to capture the accelerometer and gyroscope data
2. **BandNotification**: demonstrates how to add tiles and send them notifications
3. **BandTileEvent**: shows how to add a button to a tile and trigger an event on the phone
4. **BandRegisterNotification**: shows how the phone can send notifications to the band and display aa badge with a number

## References

http://stackoverflow.com/questions/24272184/connect-objective-c-framework-to-swift-ios-8-app-parse-framework

Microsoft Band SDK

http://developer.microsoftband.com/docs/Microsoft%20Band%20SDK.pdf

Microsoft Band Experience Design Guidelines

http://developer.microsoftband.com/docs/MicrosoftBandExperienceDesignGuidelines.pdf

## Adding a Bridging Header File

Create an XCode Swift project

Add a new objectiveC file (call it blank.m)

Would you like to configure an Objective-C bridging header? - Yes.

Drag it into the project folder

Delete the Objective-C file.

Project Properties:

Under the general tab click on + under Frameworks and Libraries

Download the Band SDK for iOS. This contains the framework (file with lego brick icon) http://developer.microsoftband.com

Select 'other' and browse to the downloaded framework file (lego brick).

Add CoreBluetooth framework as well.

Open the MicrosoftBandKit_iOS.h header file in the MicrosoftBandKit_iOS.framework folder.

Select all the #import statements and paste into the bridging header file.

