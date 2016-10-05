//
//  HomeTabViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/2/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class HomeTabViewController: UIViewController {

    @IBOutlet weak var newReservationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        newReservationButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3).CGColor
        newReservationButton.layer.cornerRadius = 8
        newReservationButton.layer.borderColor = UIColor.whiteColor().CGColor
        newReservationButton.layer.borderWidth = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension HomeTabViewController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func newReservationButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("newReservationFromHomeTabSegue", sender: self)
    }
    
}

