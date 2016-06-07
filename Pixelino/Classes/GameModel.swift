//
//  GameModel.swift
//  Pixelino
//
//  Created by Robert Mißbach on 16.06.14.
//  Copyright (c) 2014 Robert Mißbach. All rights reserved.
//


protocol GameModelDelegate
{
    func didWinGame()
    func didLoseGame()
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
        if (self.hasWon() == true)
        {
            self.delegate?.didWinGame()
        }
        else if (self.stepCounter >= self.maxNumberOfSteps())
        {
            self.delegate?.didLoseGame()
        }
    }
    
    
    // The maximum number of steps the user can make to fill the whole board with one color
    func maxNumberOfSteps() -> Int
    {
        return Int(round(CGFloat(self.colorBoard.matrix[0].count) * (CGFloat(numberOfDifferentColors) / 4.0)))
    }
    
    
    /// Returnes YES if all tiles have the same color values
    func hasWon() -> Bool
    {
        return self.colorBoard.allValuesAreEqual();
    }
}
