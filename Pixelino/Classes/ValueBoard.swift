//
//  ValueBoard.swift
//  Pixelino
//
//  Created by Robert Mißbach on 07.06.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

class ValueBoard: NSObject
{
    var matrix = Array<Array<Int>>()
    
    
    init(size:Int)
    {
        // Fill the matrix with zeros
        for _ in 0 ... size-1
        {
            var innerArray = Array<Int>()
            for _ in 0 ... size-1
            {
                innerArray.append(0)
            }
            self.matrix.append(innerArray)
        }
    }
    
    
    func fillMatrixWithRandomValues(numberOfDifferentValues:Int)
    {
        for i in 0...self.matrix[0].count - 1
        {
            for j in 0...self.matrix[1].count - 1
            {
                let randomNumber = Int(arc4random_uniform(UInt32(numberOfDifferentValues)))
                self.matrix[i][j] = randomNumber
            }
        }
    }
    
    
    func floodFill(x:Int, y:Int, oldValue:Int, newValue:Int)
    {
        if (self.matrix[x][y] == oldValue)
        {
            self.matrix[x][y] = newValue
            
            // down
            if (y + 1 < self.matrix[1].count)
            {
                self.floodFill(x, y: y + 1, oldValue: oldValue, newValue: newValue)
            }
            
            // up
            if (y > 0)
            {
                self.floodFill(x, y: y - 1, oldValue: oldValue, newValue: newValue)
            }
            
            // left
            if (x > 0)
            {
                self.floodFill(x - 1, y: y, oldValue: oldValue, newValue: newValue)
            }
            
            // right
            if (x + 1 < self.matrix[0].count)
            {
                self.floodFill(x + 1, y: y, oldValue: oldValue, newValue: newValue)
            }
            
        }
        return;
    }
    
    
    /// Returnes YES if all values in the matrix are equal
    func allValuesAreEqual() -> Bool
    {
        let currentValue = self.matrix[0][0]
        
        for i in 0...self.matrix[0].count - 1
        {
            for j in 0...self.matrix[1].count - 1
            {
                if (self.matrix[i][j] != currentValue)
                {
                    return false
                }
            }
        }
        return true;
    }
}
