//
//  GameModelSpec.swift
//  Pixelino
//
//  Created by Robert Mißbach on 05.06.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

import Quick
import Nimble

@testable import Pixelino


class GameModelSpec: QuickSpec
{
    override func spec()
    {
        let gameModel = GameModel()
        
        describe("Selecting a color")
        {
            beforeEach
            {
                let firstLine: [Int] = [1, 1]
                let secondLine: [Int] = [1, 2]
                gameModel.colorMatrix = [firstLine, secondLine];
            }
            
            it("should win the game if all fields have the same color")
            {
                gameModel.selectColor(2)
                expect(gameModel.hasWon()).to(beTrue())
            }
            
            it("should not win the game if not all fields have the same color")
            {
                gameModel.selectColor(3)
                expect(gameModel.hasWon()).to(beFalse())
            }
        }
    }
}
