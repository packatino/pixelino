//
//  AppStartCounter.swift
//  Pixelino
//
//  Created by Robert Mißbach on 18.05.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

import UIKit

class AppStartCounter: NSObject
{
    static let appStartCounterKey = "appStartCounter"
    
    /// Returns the number of times the app has been started before
    class func count() -> Int
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        let appStartCounter = defaults.integerForKey(appStartCounterKey) // 0 if not created yet
        return appStartCounter
    }
    
    /// Call this method with every app start!
    class func increment()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        let appStartCounter = defaults.integerForKey(appStartCounterKey) // 0 if not created yet
        defaults.setInteger(appStartCounter + 1, forKey:appStartCounterKey)
    }
}
