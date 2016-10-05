//
//  ChooseDateViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/4/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var firstCircle: UIView!
    @IBOutlet weak var secondCircle: UIView!
    @IBOutlet weak var thirdCircle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose Date"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        /*
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "GolfCourseImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
         */
        
        topView.layer.shadowColor = UIColor.blackColor().CGColor
        topView.layer.shadowOpacity = 0.5
        topView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        progressBarView.layer.shadowColor = UIColor.blackColor().CGColor
        progressBarView.layer.shadowOpacity = 0.5
        progressBarView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        firstCircle.layer.borderWidth = 2
        firstCircle.layer.borderColor = UIColor.blackColor().CGColor
        firstCircle.layer.cornerRadius = 15
        
        secondCircle.layer.borderWidth = 2
        secondCircle.layer.borderColor = UIColor.blackColor().CGColor
        secondCircle.layer.cornerRadius = 15
        
        thirdCircle.layer.borderWidth = 1
        thirdCircle.layer.borderColor = UIColor.lightGrayColor().CGColor
        thirdCircle.layer.cornerRadius = 15
    }
}

extension ChooseDateViewController {
    
}
