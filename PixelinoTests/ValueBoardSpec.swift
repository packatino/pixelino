//
//  ValueBoardSpec.swift
//  Pixelino
//
//  Created by Robert Mißbach on 30.06.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

import Quick
import Nimble

@testable import Pixelino


class ValueBoardSpec: QuickSpec
{
    override func spec()
    {
        describe("Initializing a board with size n")
        {
            let n = 4
            let valueBoard = ValueBoard(size: n)
            
            it("should should setup an n*n matrix")
            {
                expect(valueBoard.matrix.count).to(equal(n))
                
                let firstInnerArray : Array = valueBoard.matrix.first!
                expect(firstInnerArray.count).to(equal(n))
            }
        }
        
        describe("If all values on the board are equal")
        {
            let valueBoard = ValueBoard(size: 2)
            
            let firstLine: [Int]  = [1, 1]
            let secondLine: [Int] = [1, 1]
            valueBoard.matrix = [firstLine, secondLine];
            
            it("they should be considered as equal")
            {
                expect(valueBoard.allValuesAreEqual()).to(beTrue())
            }
        }
        
        describe("If there are different values on the board")
        {
            let valueBoard = ValueBoard(size: 2)
            
            let firstLine: [Int]  = [1, 2]
            let secondLine: [Int] = [3, 4]
            valueBoard.matrix = [firstLine, secondLine];
            
            it("they should not be considered as equal")
            {
                expect(valueBoard.allValuesAreEqual()).to(beFalse())
            }
        }
        
        describe("When the flood fill algorithm is applied")
        {
            let valueBoard = ValueBoard(size: 3)
            
            let firstLine: [Int]  = [1, 1, 3]
            let secondLine: [Int] = [3, 2, 2]
            let thirdLine: [Int]  = [2, 1, 2]
            valueBoard.matrix = [firstLine, secondLine, thirdLine]
            
            valueBoard.floodFill(0, y: 0, oldValue: 1, newValue: 2)
            
            it("should change the values that are connected to the upper left corner with the value from the upper left corner")
            {
                let firstLine: [Int]  = [2, 2, 3]
                let secondLine: [Int] = [3, 2, 2]
                let thirdLine: [Int]  = [2, 1, 2]
                let newMatrix = [firstLine, secondLine, thirdLine]
                
                expect(valueBoard.matrix).to(equal(newMatrix))
            }
        }
    }
}
