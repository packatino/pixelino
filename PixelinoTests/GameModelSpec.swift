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
        
        describe("Starting a new game")
        {
            beforeEach
            {
                gameModel.startNewGame()
            }
            
            it("should reset the step counter")
            {
                expect(gameModel.stepCounter).to(equal(0))
            }
        }
        
        describe("Selecting a color")
        {
            beforeEach
            {
                let firstLine: [Int] = [1, 1]
                let secondLine: [Int] = [1, 2]
                gameModel.colorBoard.matrix = [firstLine, secondLine];
            }
            
            it("should increment the step counter")
            {
                let stepCount = gameModel.stepCounter
                gameModel.selectColor(3)
                expect(gameModel.stepCounter).to(equal(stepCount + 1))
            }
            
            it("should not increment the step counter if the selected color is already selected")
            {
                let stepCount = gameModel.stepCounter
                gameModel.selectColor(1)
                expect(gameModel.stepCounter).to(equal(stepCount))
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
