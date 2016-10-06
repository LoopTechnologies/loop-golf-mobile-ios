//
//  ConfirmRequestViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/6/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ConfirmRequestViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var confirmRequestButton: UIButton!
    @IBOutlet weak var bottomBarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Confirm Request"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        backgroundView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        backgroundView.layer.cornerRadius = 8
        
        bottomBarView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomBarView.layer.shadowOpacity = 0.5
        bottomBarView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        confirmRequestButton.layer.cornerRadius = 8
    }
}
