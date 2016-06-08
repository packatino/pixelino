//
//  ColorBoardView.swift
//  Pixelino
//
//  Created by Robert Mißbach on 07.06.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

class ColorBoardView : UIView
{
    var colorTileViews = Array<Array<ColorTileView>>()
    
    
    init(frame: CGRect, boardSize: Int)
    {
        super.init(frame: frame)
        
        for i in 0...boardSize - 1
        {
            var innerArray = Array<ColorTileView>()
            for j in 0...boardSize - 1
            {
                let tileSize : CGFloat = frame.size.width / CGFloat(boardSize)
                let xOffset = (CGFloat(frame.size.width) - CGFloat(boardSize) * tileSize) * 0.5
                
                let colorTileView = ColorTileView()
                colorTileView.frame = CGRectMake(xOffset + CGFloat(i) * tileSize, xOffset + CGFloat(j) * tileSize, tileSize, tileSize)
                self.addSubview(colorTileView)
                
                // Add the tile to the array
                innerArray.append(colorTileView)
            }
            self.colorTileViews.append(innerArray)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateColorTileViewsWithMatrix(matrix: Array<Array<Int>>)
    {
        if matrix.count != self.colorTileViews[0].count ||
            matrix[0].count != self.colorTileViews[1].count
        {
            return
        }
        
        for i in 0...matrix[0].count - 1
        {
            for j in 0...matrix[1].count - 1
            {
                let colorInt = matrix[i][j]
                self.colorTileViews[i][j].backgroundColor = ColorMapper.colorForInt(colorInt)
            }
        }
    }
}
