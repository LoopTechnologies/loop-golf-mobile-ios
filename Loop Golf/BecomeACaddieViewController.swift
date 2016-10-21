//
//  BecomeACaddieViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/19/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class BecomeACaddieViewController: UIViewController {
    
    @IBOutlet weak var backgroundView1: UIView!
    @IBOutlet weak var backgroundView2: UIView!
    @IBOutlet weak var backgroundView3: UIView!
    @IBOutlet weak var backgroundView4: UIView!
    @IBOutlet weak var learnMoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Caddie With Loop Golf"
        navigationController!.navigationBar.tintColor = UIColor.blackColor()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        backgroundView1.layer.cornerRadius = 8
        backgroundView2.layer.cornerRadius = 8
        backgroundView3.layer.cornerRadius = 8
        backgroundView4.layer.cornerRadius = 8
        
        learnMoreButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75).CGColor
        learnMoreButton.layer.cornerRadius = 8
        learnMoreButton.layer.borderColor = UIColor.whiteColor().CGColor
        learnMoreButton.layer.borderWidth = 1
    }
}

extension BecomeACaddieViewController {
    
    @IBAction func learnMoreButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "Go to LoopGolf.com?", message: "\n More information about how to become a caddie, including the sign up process, is found on our website. Would you like to be redirected there?", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor.blackColor()
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        let goAction = UIAlertAction(title: "Go to LoopGolf.com", style: .Default) { (action) in
            
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.loopgolf.com/coming-soon/")!)
        }
        alertController.addAction(goAction)
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor.blackColor()
        }

    }
    
    
}