//
//  GameViewController.swift
//  Pixelino
//
//  Created by Robert Mißbach on 15.06.14.
//  Copyright (c) 2014 Robert Mißbach. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController, GameModelDelegate
{
    let model = GameModel()
    var colorTileViews = Array<Array<ColorTileView>>()
    let scoreLabel = UILabel()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Pixelino"
        self.view.backgroundColor = UIColor.darkGrayColor()
        
        self.model.delegate = self
        self.model.startNewGame()
        
        let yOffset : CGFloat = 80.0
        
        // Create the color tile board
        for i in 0...self.model.colorMatrixSize.0 - 1
        {
            var innerArray = Array<ColorTileView>()
            for j in 0...self.model.colorMatrixSize.1 - 1
            {
                //let tileSize : CGFloat = 20.0
                let tileSize : CGFloat = self.view.bounds.size.width / CGFloat(self.model.colorMatrixSize.0)
                let xOffset = (CGFloat(self.view.bounds.size.width) - CGFloat(self.model.colorMatrixSize.0) * tileSize) * 0.5
                let colorInt = self.model.colorMatrix[i][j]
                let color = self.colorForInt(colorInt)
                
                let colorTileView = ColorTileView()
                colorTileView.frame = CGRectMake(xOffset + CGFloat(i) * tileSize, yOffset + xOffset + CGFloat(j) * tileSize, tileSize, tileSize)
                colorTileView.backgroundColor = color
                self.view.addSubview(colorTileView)
                
                // Add the tile to the array
                innerArray.append(colorTileView)
            }
            self.colorTileViews.append(innerArray)
        }
        
        // Create the label which displays the number of steps which are left
        self.scoreLabel.frame = CGRectMake(8, yOffset + self.view.frame.size.width + 16, self.view.frame.size.width - 2 * 8, 50)
        self.scoreLabel.textAlignment = NSTextAlignment.Center
        self.scoreLabel.textColor = UIColor.whiteColor()
        self.scoreLabel.font = self.scoreLabel.font.fontWithSize(40)
        self.view.addSubview(self.scoreLabel)
        self.updateScoreLabel()
        
        // Create the color buttons
        let gapWidth : CGFloat = 12
        var x : CGFloat = gapWidth
        let buttonWidth = (self.view.frame.size.width - CGFloat(self.model.numberOfDifferentColors + 1) * gapWidth) / CGFloat(self.model.numberOfDifferentColors);
        let y : CGFloat = self.view.bounds.size.height - gapWidth - buttonWidth;
        for i in 0...self.model.numberOfDifferentColors - 1
        {
            let colorButton = UIButton()
            colorButton.backgroundColor = self.colorForInt(i)
            colorButton.tag = i
            colorButton.frame = CGRectMake(x, y, buttonWidth, buttonWidth)
            self.view.addSubview(colorButton)
            
            colorButton.addTarget(self, action: #selector(GameViewController.didPressColorButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            x = x + buttonWidth + gapWidth;
        }
    }
    
    
    /// Updates the color tile views with the data from the model
    func updateColorTileViews()
    {
        for i in 0...self.model.colorMatrixSize.0 - 1
        {
            for j in 0...self.model.colorMatrixSize.1 - 1
            {
                let colorInt = self.model.colorMatrix[i][j]
                self.colorTileViews[i][j].backgroundColor = self.colorForInt(colorInt)
            }
        }
    }
    
    
    func updateScoreLabel()
    {
        self.scoreLabel.text = "\(self.model.stepCounter) von \(self.model.maxNumberOfSteps)"
    }
    
    
    func startNewGame()
    {
        self.model.startNewGame()
        self.updateColorTileViews()
        self.updateScoreLabel()
    }
    
    
    /// Is called when one of the color buttons is pressed
    func didPressColorButton(sender : UIButton)
    {
        let buttonIndex = sender.tag;
        self.model.selectColor(buttonIndex)
        
        self.updateColorTileViews()
        self.updateScoreLabel()
    }
    
    
    func didWinGame()
    {
        let alertController = UIAlertController(title: "Sieg",
                                                message: "Du hast das Spiel in \(self.model.stepCounter) Zügen gewonnen!",
                                                preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: ":-)", style: .Default) { (action) in
            self.startNewGame()
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true){}
    }
    
    
    func didLoseGame()
    {
        let alertController = UIAlertController(title: "Game Over",
                                                message: "Leider verloren. Versuch es noch einmal!",
                                                preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.startNewGame()
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true){}
    }
    
    
    func colorForInt(index:Int) -> UIColor
    {
        switch (index)
            {
        case 0:
            return UIColor(red: 0.65, green: 0.02, blue: 0.0, alpha: 1.0)
            
        case 1:
            return UIColor(red: 0.15, green: 0.59, blue: 0.18, alpha: 1.0)
            
        case 2:
            return UIColor(red: 0.12, green: 0.1, blue: 0.7, alpha: 1.0)
            
        case 3:
            return UIColor(red: 1.0, green: 0.76, blue: 0.0, alpha: 1.0)
            
        default:
            return UIColor.blackColor()
        }
    }
}