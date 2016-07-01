//
//  ColorBoardViewSpec.swift
//  Pixelino
//
//  Created by Robert Mißbach on 01.07.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

import Quick
import Nimble

@testable import Pixelino


class ColorBoardViewSpec: QuickSpec
{
    override func spec()
    {
        describe("Updating the color board view")
        {
            let initialColor = UIColor.whiteColor()
            
            let view00 = UIView()
            view00.backgroundColor = initialColor
            let view01 = UIView()
            view01.backgroundColor = initialColor
            let view10 = UIView()
            view10.backgroundColor = initialColor
            let view11 = UIView()
            view11.backgroundColor = initialColor
            
            let firstLine: [UIView]  = [view00, view01]
            let secondLine: [UIView] = [view10, view11]
            
            let colorBoardView = ColorBoardView(frame: CGRectZero, boardSize: 2)
            colorBoardView.colorTileViews = [firstLine, secondLine];
            
            context("with a valid matrix")
            {
                let firstLine: [Int]  = [1, 2]
                let secondLine: [Int] = [3, 4]
                let updateMatrix = [firstLine, secondLine];
                
                colorBoardView.updateColorTileViewsWithMatrix(updateMatrix)
                
                it("should change the background colors of the tile views on the board")
                {
                    for currentLine in colorBoardView.colorTileViews
                    {
                        for currentView in currentLine
                        {
                            expect(currentView.backgroundColor).toNot(equal(initialColor))
                        }
                    }
                }
            }
            
            context("with an invalid matrix")
            {
                it("should not lead to an app crash")
                {
                    //TODO: Implement this
                }
                
                it("should not update any color tiles")
                {
                    //TODO: Implement this
                }
            }
        }
    }
}
