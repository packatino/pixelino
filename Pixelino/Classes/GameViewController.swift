//
//  GameViewController.swift
//  Pixelino
//
//  Created by Robert Mißbach on 15.06.14.
//  Copyright (c) 2014 Robert Mißbach. All rights reserved.
//

class GameViewController: UIViewController, GameModelDelegate
{
    let model = GameModel()
    var colorBoardView = ColorBoardView(frame: CGRectZero, boardSize: 1)
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
        let colorBoardFrame = CGRect(x: 0, y: yOffset, width: self.view.bounds.size.width, height: self.view.bounds.size.width)
        
        self.colorBoardView = ColorBoardView(frame: colorBoardFrame, boardSize: self.model.colorBoard.matrix[0].count)
        self.view.addSubview(self.colorBoardView)
        
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
            colorButton.backgroundColor = self.colorBoardView.colorForInt(i)
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
        
        self.colorBoardView.updateColorTileViewsWithMatrix(self.model.colorBoard.matrix)
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
        self.colorBoardView.updateColorTileViewsWithMatrix(self.model.colorBoard.matrix)
        self.updateScoreLabel()
        
        GoogleAnalyticsTracker.trackEvent(GoogleAnalyticsTracker.TrackingCategory.Game.rawValue,
                                          action:GoogleAnalyticsTracker.TrackingAction.Started.rawValue,
                                          label:"challenge", // game mode
            value:nil)
    }
    
    
    func updateScoreLabel()
    {
        let movesLeft = self.model.maxNumberOfSteps() - self.model.stepCounter
        
        if movesLeft == 1
        {
            self.scoreLabel.text = NSLocalizedString("1 move left", comment: "")
        }
        else
        {
            self.scoreLabel.text = String(format: NSLocalizedString("%i moves left", comment: ""), movesLeft)
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