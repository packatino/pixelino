//
//  GameModel.swift
//  Pixelino
//
//  Created by Robert Mißbach on 16.06.14.
//  Copyright (c) 2014 Robert Mißbach. All rights reserved.
//

import Foundation
import UIKit


protocol GameModelDelegate
{
    func didWinGame()
    func didLoseGame()
}


class GameModel : NSObject
{
    let numberOfDifferentColors = 4
    let colorMatrixSize = (13, 13)
    var colorMatrix = Array<Array<Int>>()
    var stepCounter = 0
    
    var delegate : GameModelDelegate?
    
    
    override init()
    {
        super.init()
        self.createColorMatrix()
    }
    
    
    func startNewGame()
    {
        self.stepCounter = 0
        
        for i in 0...self.colorMatrix[0].count - 1
        {
            for j in 0...self.colorMatrix[1].count - 1
            {
                let randomNumber = Int(arc4random_uniform(UInt32(self.numberOfDifferentColors)))
                self.colorMatrix[i][j] = randomNumber
            }
        }
    }
    
    
    func createColorMatrix()
    {
        for _ in 0...self.colorMatrixSize.0 - 1
        {
            var innerArray = Array<Int>()
            for _ in 0...self.colorMatrixSize.1 - 1
            {
                innerArray.append(0)
            }
            self.colorMatrix.append(innerArray)
        }
    }
    
    
    func selectColor(newColorInt:Int)
    {
        let oldColorInt = self.colorMatrix[0][0]
        
        // two times the same color doesn't make sense so we assume it was not intentionally and don't count it
        if newColorInt == oldColorInt
        {
            return
        }
        
        self.floodFill(0, y: 0, oldColorInt: oldColorInt, newColorInt: newColorInt)
        
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
        return Int(round(CGFloat(colorMatrixSize.0) * (CGFloat(numberOfDifferentColors) / 4.0)))
    }
    
    
    /// Returnes YES if all tiles have the same color values
    func hasWon() -> Bool
    {
        let currentColor = self.colorMatrix[0][0]
        
        for i in 0...self.colorMatrix[0].count - 1
        {
            for j in 0...self.colorMatrix[1].count - 1
            {
                if (self.colorMatrix[i][j] != currentColor)
                {
                    return false
                }
            }
        }
        return true;
    }
    
    
    func floodFill(x:Int, y:Int, oldColorInt:Int, newColorInt:Int)
    {
        if (self.colorMatrix[x][y] == oldColorInt)
        {
            self.colorMatrix[x][y] = newColorInt
            
            // down
            if (y + 1 < self.colorMatrix[1].count)
            {
                self.floodFill(x, y: y + 1, oldColorInt: oldColorInt, newColorInt: newColorInt)
            }
            
            // up
            if (y > 0)
            {
                self.floodFill(x, y: y - 1, oldColorInt: oldColorInt, newColorInt: newColorInt)
            }
            
            // left
            if (x > 0)
            {
                self.floodFill(x - 1, y: y, oldColorInt: oldColorInt, newColorInt: newColorInt)
            }
            
            // right
            if (x + 1 < self.colorMatrix[0].count)
            {
                self.floodFill(x + 1, y: y, oldColorInt: oldColorInt, newColorInt: newColorInt)
            }
            
        }
        return;
    }
}