//
//  AppStartCounterSpec.swift
//  Pixelino
//
//  Created by Robert Mißbach on 05.06.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

import Quick
import Nimble

@testable import Pixelino


class AppStartCounterSpec: QuickSpec
{
    override func spec()
    {
        let initialCount = AppStartCounter.count()
        
        describe("after incrementing the count")
        {
            AppStartCounter.increment()
            
            it("the new count should be greater than the initial count")
            {
                // Normally I would expect that the new count is equal to the initial count + 1
                // but the problem is that AppStartCounter.increment() is also called by the AppDelegate
                // when the app is started which means that at this point the new count is always equal
                // to the initial count + 2. I'm still wondering how I could solve this elegantly...
                expect(AppStartCounter.count()) > initialCount
            }
        }
    }
}
