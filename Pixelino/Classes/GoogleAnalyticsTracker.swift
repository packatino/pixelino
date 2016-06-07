//
//  GoogleAnalyticsTracker.swift
//  Pixelino
//
//  Created by Robert Mißbach on 17.05.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

class GoogleAnalyticsTracker: NSObject
{
    enum TrackingCategory: String
    {
        case App = "App"
        case Game = "Game"
    }
    
    enum TrackingAction: String
    {
        case Started = "started"
        case Finished = "finished"
    }
    
    
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
    
    
    class func trackEvent(category:String, action:String, label:String?, value:NSNumber?)
    {
        #if DEBUG
            print("Would track event '\(category)', '\(action)', '\(label)', '\(value)'")
        #else
            let tracker = GAI.sharedInstance().defaultTracker
            tracker.send(GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: value).build() as [NSObject : AnyObject])
        #endif
    }
}
