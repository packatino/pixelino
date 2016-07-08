//
//  GameModel.swift
//  Pixelino
//
//  Created by Robert Mißbach on 16.06.14.
//  Copyright (c) 2014 Robert Mißbach. All rights reserved.
//


protocol GameModelDelegate
{
    func gameModelDidChangeBoard(gameModel:GameModel)
    func gameModelDidWinGame(gameModel:GameModel)
    func gameModelDidLoseGame(gameModel:GameModel)
}


class GameModel : NSObject
{
    let numberOfDifferentColors = 4
    let colorBoard = ValueBoard(size: 13)
    var stepCounter = 0
    var delegate : GameModelDelegate?
    
    
    func startNewGame()
    {
        self.stepCounter = 0
        self.colorBoard.fillMatrixWithRandomValues(numberOfDifferentColors)
        self.delegate?.gameModelDidChangeBoard(self)
    }
    
    
    func selectColor(newColorInt:Int)
    {
        let oldColorInt = self.colorBoard.matrix[0][0]
        
        // two times the same color doesn't make sense so we assume it was not intentionally and don't count it
        if newColorInt == oldColorInt
        {
            return
        }
        
        self.colorBoard.floodFill(0, y: 0, oldValue: oldColorInt, newValue: newColorInt)
        
        self.stepCounter += 1
        
        self.delegate?.gameModelDidChangeBoard(self)
        
        if (self.hasWon() == true)
        {
            self.delegate?.gameModelDidWinGame(self)
        }
        else if (self.remainingNumberOfSteps() <= 0)
        {
            self.delegate?.gameModelDidLoseGame(self)
        }
    }
    
    
    // The maximum number of steps the user can make to fill the whole board with one color
    func maxNumberOfSteps() -> Int
    {
        return Int(round(CGFloat(self.colorBoard.matrix[0].count) * (CGFloat(numberOfDifferentColors) / 4.0)))
    }
    
    
    // Returns the remaining number of steps the user can make until the game is over
    func remainingNumberOfSteps() -> Int
    {
        return self.maxNumberOfSteps() - self.stepCounter
    }
    
    
    /// Returnes YES if all tiles have the same color values
    func hasWon() -> Bool
    {
        return self.colorBoard.allValuesAreEqual();
    }
}
