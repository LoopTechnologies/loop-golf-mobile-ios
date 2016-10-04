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
    var courseNames = ["Hearthstone Country Club", "Black Hawk Country Club"]
    var courseLocations = ["Cypress, Texas","Richmond, Texas"]
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var segmentedControlBackgroundView: UIView!
    @IBOutlet weak var nearbyCoursesContainer: UIView!
    @IBOutlet weak var favoriteCoursesContainer: UIView!
    
    var courseNamesSent = [String]()
    var courseLocationsSent = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        segmentedControlBackgroundView.layer.shadowColor = UIColor.blackColor().CGColor
        segmentedControlBackgroundView.layer.shadowOpacity = 0.5
        segmentedControlBackgroundView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        
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