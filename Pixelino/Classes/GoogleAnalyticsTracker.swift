//
//  GoogleAnalyticsTracker.swift
//  Pixelino
//
//  Created by Robert Mißbach on 17.05.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

import UIKit

class GoogleAnalyticsTracker: NSObject
{
    class func initTracker()
    {
        // Configure tracker from GoogleService-Info.plist.
        #if DEBUG
            print("Would configure the Google Analytics tracker.")
        #else
            var configureError:NSError?
            GGLContext.sharedInstance().configureWithError(&configureError)
            assert(configureError == nil, "Error configuring Google services: \(configureError)")
        #endif
    }
    
    
    class func trackScreenView(screenName: String)
    {
        #if DEBUG
            print("Would track screen view '\(screenName)'")
        #else
            let tracker = GAI.sharedInstance().defaultTracker
            tracker.set(kGAIScreenName, value:screenName)
            let builder = GAIDictionaryBuilder.createScreenView()
            tracker.send(builder.build() as [NSObject : AnyObject])
        #endif
    }
}
