
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /* This method is your app’s first chance to execute code at launch time. */
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        print("application:willFinishLaunchingWithOptions")
        return true
    }

    /* This method allows you to perform any final initialization before your app is displayed to the user */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        print("application:didFinishLaunchingWithOptions")
        NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 3))
        return true
    }

    /* Lets you know that your app is transitioning away from being the foreground app. Use this method to put your app into a quiescent state. */
    func applicationWillResignActive(application: UIApplication) {
        print("applicationWillResignActive")
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    /* Lets you know that your app is now running in the background and may be suspended at any time. */
    func applicationDidEnterBackground(application: UIApplication) {
        print("applicationDidEnterBackground")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    /* Lets you know that your app is moving out of the background and back into the foreground, but that it is not yet active. */
    func applicationWillEnterForeground(application: UIApplication) {
        print("applicationWillEnterForeground")
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    /* Lets your app know that it is about to become the foreground app. Use this method for any last minute preparation. */
    func applicationDidBecomeActive(application: UIApplication) {
        print("applicationWillEnterForeground")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    /* Lets you know that your app is being terminated. This method is not called if your app is suspended. */
    func applicationWillTerminate(application: UIApplication) {
        print("applicationWillTerminate")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

