//
//  CourseDetailsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/4/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class CourseDetailsViewController: UIViewController {
    
    @IBOutlet weak var courseNameLabel: UILabel!
    
    // Receive data via segue.
    var courseNameReceived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "GolfCourseImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        if (courseNameReceived != "") {
            courseNameLabel.text = courseNameReceived!
        }
        
    }
}

extension CourseDetailsViewController {
    
    @IBAction func dismissVCButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
}
