//
//  ChooseCaddieViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/5/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ChooseCaddieViewController: UIViewController {
    
    @IBOutlet weak var navBarShadowView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseLocationLabel: UILabel!
    @IBOutlet weak var resDateTimeLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var firstCircle: UIView!
    @IBOutlet weak var secondCircle: UIView!
    @IBOutlet weak var thirdCircle: UIView!
    
    // Receive data via segue.
    var courseIDReceived: String?
    var courseNameReceived: String?
    var courseLocationReceived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Nearby Caddies"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()        
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        navBarShadowView.layer.shadowColor = UIColor.blackColor().CGColor
        navBarShadowView.layer.shadowOpacity = 0.5
        navBarShadowView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        topBarView.layer.shadowColor = UIColor.blackColor().CGColor
        topBarView.layer.shadowOpacity = 0.5
        topBarView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        firstCircle.layer.borderWidth = 2
        firstCircle.layer.borderColor = UIColor.blackColor().CGColor
        firstCircle.layer.cornerRadius = 15
        
        secondCircle.layer.borderWidth = 2
        secondCircle.layer.borderColor = UIColor.blackColor().CGColor
        secondCircle.layer.cornerRadius = 15
        
        thirdCircle.layer.borderWidth = 2
        thirdCircle.layer.borderColor = UIColor.blackColor().CGColor
        thirdCircle.layer.cornerRadius = 15
        
        if (courseNameReceived != "") {
            courseNameLabel.text = courseNameReceived!
        }
        
        if (courseLocationReceived != "") {
            courseLocationLabel.text = courseLocationReceived!
        }
    }
}

extension ChooseCaddieViewController {
    
}
