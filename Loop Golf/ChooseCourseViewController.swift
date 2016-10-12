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
    var courseNames = ["Memorial Park Golf Course", "Wildcat Golf Club", "The Club at Falcon Point", "Black Hawk Country Club", "The Club at Carlton Woods Creekside"]
    var courseLocations = ["Houston, Texas", "Houston, Texas", "Katy, Texas", "Richmond, Texas", "The Woodlands, Texas"]
    var courseDistances = [1.4, 9.7, 21.9, 28.2, 34.3]
    var coursePrices = [62, 68, 78, 82, 94]
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var segmentedControlBackgroundView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var firstCircle: UIView!
    @IBOutlet weak var secondCircle: UIView!
    @IBOutlet weak var thirdCircle: UIView!
    @IBOutlet weak var nearbyCoursesContainer: UIView!
    @IBOutlet weak var favoriteCoursesContainer: UIView!
    
    var selectedIndex = Int()
    
    // Send data to child VC via segue.
    var courseNamesForChild = [String]()
    var courseLocationsForChild = [String]()
    var courseDistancesForChild = [Double]()
    var coursePricesForChild = [Int]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notifyWithSelectedIndex:", name: "selectedIndexNotification", object: nil)

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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "selectedIndexNotification", object: self.view.window)
    }
}

extension ChooseCourseViewController {
    
    func notifyWithSelectedIndex (notification: NSNotification) {
        selectedIndex = notification.object! as! Int
        
        switch (selectedIndex) {
        case 0:
            nearbyCoursesContainer.hidden = false
            favoriteCoursesContainer.hidden = true
        case 1:
            nearbyCoursesContainer.hidden = true
            favoriteCoursesContainer.hidden = false
        default:
            break
        }
    }
    
    @IBAction func dismissVCButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        courseNamesForChild = courseNames
        courseLocationsForChild = courseLocations
        courseDistancesForChild = courseDistances
        coursePricesForChild = coursePrices

        if (segue.identifier == "nearbyCoursesContainerSegue") {
            let nearbyCoursesContainer = segue.destinationViewController as! NearbyCoursesContainerViewController
            nearbyCoursesContainer.courseNamesReceived = courseNamesForChild
            nearbyCoursesContainer.courseLocationsReceived = courseLocationsForChild
            nearbyCoursesContainer.courseDistancesReceived = courseDistancesForChild
            nearbyCoursesContainer.coursePricesReceived = coursePricesForChild
        }
        
        if (segue.identifier == "favoriteCoursesContainerSegue") {
            let favoriteCoursesContainer = segue.destinationViewController as! FavoriteCoursesContainerViewController
            favoriteCoursesContainer.courseNamesReceived = courseNamesForChild
            favoriteCoursesContainer.courseLocationsReceived = courseLocationsForChild
            favoriteCoursesContainer.courseDistancesReceived = courseDistancesForChild
            favoriteCoursesContainer.coursePricesReceived = coursePricesForChild
        }
    }
    
}