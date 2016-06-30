//
//  ColorMapperSpec.swift
//  Pixelino
//
//  Created by Robert Mißbach on 30.06.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

import Quick
import Nimble

@testable import Pixelino


class ColorMapperSpec: QuickSpec
{
    override func spec()
    {
        describe("The color mapper")
        {
            it("should return a color for all values from 0 to 3")
            {
                for i in 0...3
                {
                    expect(ColorMapper.colorForInt(i)).toNot(beNil())
                }
            }
            
            it("should return black color for an invalid integer")
            {
                expect(ColorMapper.colorForInt(999)).to(equal(UIColor.blackColor()))
            }
        }
    }
}
