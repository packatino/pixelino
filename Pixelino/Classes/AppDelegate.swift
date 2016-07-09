//
//  AppDelegate.swift
//  Pixelino
//
//  Created by Robert Mißbach on 15.06.14.
//  Copyright (c) 2014 Robert Mißbach. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool
    {
        GoogleAnalyticsTracker.initTracker()
        GoogleAnalyticsTracker.trackEvent(GoogleAnalyticsTracker.TrackingCategory.App.rawValue,
                                          action:GoogleAnalyticsTracker.TrackingAction.Started.rawValue,
                                          label:AppStartCounter.count() == 0 ? "firstTime" : nil,
                                          value:nil)
        AppStartCounter.increment()
        
        return true
    }
}

