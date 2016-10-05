//
//  ChooseCourseViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ChooseCourseViewController: UIViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var courseNames = ["Hearthstone Country Club", "Black Hawk Country Club", "The Club at Falcon Point", "The Club at Carlton Woods Creekside"]
    var courseLocations = ["Cypress, Texas","Richmond, Texas", "Katy, Texas", "The Woodlands, Texas"]
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var segmentedControlBackgroundView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var firstCircle: UIView!
    @IBOutlet weak var secondCircle: UIView!
    @IBOutlet weak var thirdCircle: UIView!
    
    @IBOutlet weak var nearbyCoursesContainer: UIView!
    @IBOutlet weak var favoriteCoursesContainer: UIView!
    
    var courseNamesSent = [String]()
    var courseLocationsSent = [String]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()

        segmentedControlBackgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        segmentedControlBackgroundView.layer.shadowOpacity = 0.5
        segmentedControlBackgroundView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        progressBarView.layer.shadowColor = UIColor.blackColor().CGColor
        progressBarView.layer.shadowOpacity = 0.5
        progressBarView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        firstCircle.layer.borderWidth = 2
        firstCircle.layer.borderColor = UIColor.blackColor().CGColor
        firstCircle.layer.cornerRadius = 15
        
        secondCircle.layer.borderWidth = 1
        secondCircle.layer.borderColor = UIColor.lightGrayColor().CGColor
        secondCircle.layer.cornerRadius = 15
        
        thirdCircle.layer.borderWidth = 1
        thirdCircle.layer.borderColor = UIColor.lightGrayColor().CGColor
        thirdCircle.layer.cornerRadius = 15
        
        favoriteCoursesContainer.hidden = true
        
    }
}

extension ChooseCourseViewController {
    
    @IBAction func dismissVCButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        courseNamesSent = courseNames
        courseLocationsSent = courseLocations

        if (segue.identifier == "nearbyCoursesContainerSegue") {
            let nearbyCoursesContainer = segue.destinationViewController as! NearbyCoursesContainerViewController
            nearbyCoursesContainer.courseNamesReceived = courseNamesSent
            nearbyCoursesContainer.courseLocationsReceived = courseLocationsSent
        }
    }
    
}