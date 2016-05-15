//
//  ColorTile.swift
//  Pixelino
//
//  Created by Robert Mißbach on 16.06.14.
//  Copyright (c) 2014 Robert Mißbach. All rights reserved.
//

import Foundation
import UIKit


class ColorTileView : UIView
{
    var color : UIColor
    {
        get
        {
            return self.backgroundColor!
        }
        set
        {
            self.backgroundColor = newValue
        }
    }
}