//
//  AppDelegate.swift
//  Pixelino
//
//  Created by Robert Mißbach on 15.06.14.
//  Copyright (c) 2014 Robert Mißbach. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool
    {
        // Increment and count the number of times the app has been started
        let appStartCounterKey = "appStartCounter"
        let defaults = NSUserDefaults.standardUserDefaults()
        let appStartCounter = defaults.integerForKey(appStartCounterKey) // 0 if not created yet
        defaults.setInteger(appStartCounter + 1, forKey:appStartCounterKey)
        print("App started (\(appStartCounter))")
        
        GoogleAnalyticsTracker.initTracker()
        GoogleAnalyticsTracker.trackEvent(GoogleAnalyticsTracker.TrackingCategory.App.rawValue,
                                          action:GoogleAnalyticsTracker.TrackingAction.Started.rawValue,
                                          label:appStartCounter == 0 ? "firstTime" : nil,
                                          value:nil)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

