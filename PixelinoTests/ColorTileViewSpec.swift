//
//  ColorTileViewSpec.swift
//  Pixelino
//
//  Created by Robert Mißbach on 05.06.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

import Quick
import Nimble

@testable import Pixelino


class ColorTileViewSpec: QuickSpec
{
    override func spec()
    {
        describe("changing the color")
        {
            let colorTileView = ColorTileView()
            colorTileView.color = UIColor.redColor();
            
            it("should also change the background color")
            {
                expect(colorTileView.backgroundColor).to(equal(UIColor.redColor()))
            }
        }
    }
}
