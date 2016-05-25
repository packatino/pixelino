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
    
    
    // MARK: View live cycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Pixelino"
        self.view.backgroundColor = UIColor.darkGrayColor()
        
        GoogleAnalyticsTracker.trackScreenView("Game")
        
        self.model.delegate = self
        
        // we have to make the layout a little more compact for the iPhone 4
        let iPhone4 = UIDevice().userInterfaceIdiom == .Phone && UIScreen.mainScreen().nativeBounds.height < 1136
        
        let yOffset : CGFloat = 64.0 + (iPhone4 ? 0 : 16)
        
        // Create the color tile board
        for i in 0...self.model.colorMatrixSize.0 - 1
        {
            var innerArray = Array<ColorTileView>()
            for j in 0...self.model.colorMatrixSize.1 - 1
            {
                //let tileSize : CGFloat = 20.0
                let tileSize : CGFloat = self.view.bounds.size.width / CGFloat(self.model.colorMatrixSize.0)
                let xOffset = (CGFloat(self.view.bounds.size.width) - CGFloat(self.model.colorMatrixSize.0) * tileSize) * 0.5
                
                let colorTileView = ColorTileView()
                colorTileView.frame = CGRectMake(xOffset + CGFloat(i) * tileSize, yOffset + xOffset + CGFloat(j) * tileSize, tileSize, tileSize)
                self.view.addSubview(colorTileView)
                
                // Add the tile to the array
                innerArray.append(colorTileView)
            }
            self.colorTileViews.append(innerArray)
        }
        
        // Create the label which displays the number of steps which are left
        self.scoreLabel.frame = CGRectMake(8, yOffset + self.view.frame.size.width + (iPhone4 ? 6 : 16), self.view.frame.size.width - 2 * 8, iPhone4 ? 27 : 50)
        self.scoreLabel.textAlignment = NSTextAlignment.Center
        self.scoreLabel.textColor = UIColor.whiteColor()
        self.scoreLabel.font = self.scoreLabel.font.fontWithSize(iPhone4 ? 24 : 40)
        self.view.addSubview(self.scoreLabel)
        
        // Create the color buttons
        var gapWidth : CGFloat = 12
        var x : CGFloat = gapWidth
        let maxHeight : CGFloat = self.view.bounds.size.height - 2 * gapWidth - self.scoreLabel.frame.origin.y - self.scoreLabel.frame.size.height
        let buttonWidth = min(maxHeight, (self.view.frame.size.width - CGFloat(self.model.numberOfDifferentColors + 1) * gapWidth) / CGFloat(self.model.numberOfDifferentColors))
        let y : CGFloat = self.view.bounds.size.height - gapWidth - buttonWidth;
        gapWidth = (self.view.bounds.size.width - CGFloat(self.model.numberOfDifferentColors) * buttonWidth - 2 * gapWidth) / CGFloat(self.model.numberOfDifferentColors - 1);
        for i in 0...self.model.numberOfDifferentColors - 1
        {
            let colorButton = UIButton()
            colorButton.backgroundColor = self.colorForInt(i)
            colorButton.tag = i
            colorButton.frame = CGRectMake(x, y, buttonWidth, buttonWidth)
            colorButton.layer.borderColor = UIColor.whiteColor().CGColor
            colorButton.layer.borderWidth = 4.0
            self.view.addSubview(colorButton)
            
            colorButton.addTarget(self, action: #selector(GameViewController.didPressColorButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            x = x + buttonWidth + gapWidth;
        }
        
        startNewGame()
        
        if AppStartCounter.count() == 1
        {
            openHelp()
        }
        
        let infoButton = UIBarButtonItem(image: UIImage(named: "nav_bar_item_info"),
                                         style: UIBarButtonItemStyle.Plain ,
                                         target: self,
                                         action: #selector(GameViewController.openHelp))
        self.navigationItem.rightBarButtonItem = infoButton
    }
    
    
    // MARK: Actions and navigation
    
    /// Is called when one of the color buttons is pressed
    func didPressColorButton(sender : UIButton)
    {
        let buttonIndex = sender.tag;
        self.model.selectColor(buttonIndex)
        
        self.updateColorTileViews()
        self.updateScoreLabel()
    }
    
    
    /// Opens a help which tells the user how to play the game
    func openHelp()
    {
        let alertController = UIAlertController(title: NSLocalizedString("ALERT_HELP_TITLE", comment: ""),
                                                message: String(format: NSLocalizedString("ALERT_HELP_MESSAGE", comment: ""), self.model.stepCounter),
                                                preferredStyle: .Alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ALERT_HELP_BUTTON", comment: ""), style: .Default) { (action) in}
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true){}
    }
    
    
    // MARK: Other methods
    
    func startNewGame()
    {
        self.model.startNewGame()
        self.updateColorTileViews()
        self.updateScoreLabel()
        
        GoogleAnalyticsTracker.trackEvent(GoogleAnalyticsTracker.TrackingCategory.Game.rawValue,
                                          action:GoogleAnalyticsTracker.TrackingAction.Started.rawValue,
                                          label:"challenge", // game mode
            value:nil)
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
        let movesLeft = self.model.maxNumberOfSteps - self.model.stepCounter
        
        if movesLeft == 1
        {
            self.scoreLabel.text = NSLocalizedString("1 move left", comment: "")
        }
        else
        {
            self.scoreLabel.text = String(format: NSLocalizedString("%i moves left", comment: ""), movesLeft)
        }
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
    
    
    // MARK: GameModelDelegate
    
    func didWinGame()
    {
        GoogleAnalyticsTracker.trackEvent(GoogleAnalyticsTracker.TrackingCategory.Game.rawValue,
                                          action:GoogleAnalyticsTracker.TrackingAction.Finished.rawValue,
                                          label:"win",
                                          value:nil)
        
        let alertController = UIAlertController(title: NSLocalizedString("ALERT_VICTORY_TITLE", comment: ""),
                                                message: String(format: NSLocalizedString("ALERT_VICTORY_MESSAGE", comment: ""), self.model.stepCounter),
                                                preferredStyle: .Alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ALERT_VICTORY_BUTTON", comment: ""), style: .Default) { (action) in
            self.startNewGame()
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true){}
    }
    
    
    func didLoseGame()
    {
        GoogleAnalyticsTracker.trackEvent(GoogleAnalyticsTracker.TrackingCategory.Game.rawValue,
                                          action:GoogleAnalyticsTracker.TrackingAction.Finished.rawValue,
                                          label:"lose",
                                          value:nil)
        
        let alertController = UIAlertController(title: NSLocalizedString("ALERT_GAME_OVER_TITLE", comment: ""),
                                                message: NSLocalizedString("ALERT_GAME_OVER_MESSAGE", comment: ""),
                                                preferredStyle: .Alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ALERT_GAME_OVER_BUTTON", comment: ""), style: .Default) { (action) in
            self.startNewGame()
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true){}
    }
}