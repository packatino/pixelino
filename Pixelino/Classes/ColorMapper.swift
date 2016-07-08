//
//  ColorMapper.swift
//  Pixelino
//
//  Created by Robert Mißbach on 08.06.16.
//  Copyright © 2016 Robert Mißbach. All rights reserved.
//

class ColorMapper
{
    class func colorForInt(index:Int) -> UIColor
    {
        switch (index)
        {
        case 0: // red
            return UIColor(red: 0.65, green: 0.02, blue: 0.0, alpha: 1.0)
            
        case 1: // green
            return UIColor(red: 0.15, green: 0.59, blue: 0.18, alpha: 1.0)
            
        case 2: // blue
            return UIColor(red: 0.12, green: 0.1, blue: 0.7, alpha: 1.0)
            
        case 3: // yellow
            return UIColor(red: 1.0, green: 0.76, blue: 0.0, alpha: 1.0)
            
        default:
            return UIColor.blackColor()
        }
    }
}