//
//  ReservationsTabViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ReservationsTabViewController: UIViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    
    
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var requestedContainer: UIView!
    @IBOutlet weak var confirmedContainer: UIView!
    
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notifyWithSelectedIndex:", name: "selectedIndexNotification", object: nil)
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        roundedBackgroundView.layer.cornerRadius = 8

        confirmedContainer.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "selectedIndexNotification", object: self.view.window)
    }
}

extension ReservationsTabViewController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    func notifyWithSelectedIndex (notification: NSNotification) {
        selectedIndex = notification.object! as! Int
        
        if (selectedIndex == 0) {
            requestedContainer.hidden = false
            confirmedContainer.hidden = true
        } else if (selectedIndex == 1) {
            requestedContainer.hidden = true
            confirmedContainer.hidden = false
        }
    }
}
