//
//  FavoriteCoursesContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class FavoriteCoursesContainerViewController: UITableViewController {
    
    var courseNames = [String]()
    var courseLocations = [String]()
    var courseDistances = [Double]()
    var coursePrices = [Int]()
    
    // Receive data from parent VC via segue.
    var courseNamesReceived: [String]?
    var courseLocationsReceived: [String]?
    var courseDistancesReceived: [Double]?
    var coursePricesReceived: [Int]?
    
    // Send data via segue.
    var courseNameForSegue = String()
    var courseLocationForSegue = String()
    var coursePriceForSegue = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseNames = []
        //courseNames = courseNamesReceived!
        courseLocations = courseLocationsReceived!
        courseDistances = courseDistancesReceived!
        coursePrices = coursePricesReceived!
    }
}

extension FavoriteCoursesContainerViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 251
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (courseNames.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "You don't have any golf courses \n in My Favorites. Add golf courses \n by tapping the Favorite icon \n found in course details."
            noDataLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
            noDataLabel.textColor = UIColor.whiteColor()
            noDataLabel.textAlignment = NSTextAlignment.Center
            noDataLabel.numberOfLines = 0
            noDataLabel.lineBreakMode = .ByWordWrapping
            tableView.backgroundView = noDataLabel
            tableView.backgroundColor = UIColor.blackColor()
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        return numOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ChooseCourseTableViewCell
        
        cell.golfCourseImageView.image = UIImage(named: "GolfCourseImage")
        cell.courseNameLabel.text = courseNames[indexPath.row] as? String
        cell.coursePriceLabel.text = "$\(coursePrices[indexPath.row])"
        cell.courseLocationLabel.text = courseLocations[indexPath.row] as? String
        cell.courseDistanceLabel.text = "\(courseDistances[indexPath.row]) mi"
        
        cell.moreButton.layer.borderWidth = 1
        cell.moreButton.layer.borderColor = UIColor.blackColor().CGColor
        cell.moreButton.layer.cornerRadius = 8
        
        cell.moreButton.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChooseCourseTableViewCell
        
        courseNameForSegue = courseNames[indexPath.row]
        courseLocationForSegue = courseLocations[indexPath.row]
        coursePriceForSegue = coursePrices[indexPath.row]
        
        cell.imageCoverView.alpha =  0.5
        
        performSegueWithIdentifier("toChooseDateSegue", sender: self)
        
        UIView.animateWithDuration(0.1, delay: 0.5, options: .CurveLinear, animations: {
            cell.imageCoverView.alpha =  0.2
            }, completion: nil)
    }
    
    @IBAction func moreButtonPressed(sender: UIButton) {
        var moreButtonPosition = sender.convertPoint(CGPointZero, toView: self.tableView)
        var indexPath = self.tableView.indexPathForRowAtPoint(moreButtonPosition)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath!) as! ChooseCourseTableViewCell
        
        courseNameForSegue = courseNames[indexPath!.row]
        
        performSegueWithIdentifier("nearbyCourseDetailsSegue", sender: indexPath)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "nearbyCourseDetailsSegue") {
            var indexPath: NSIndexPath = (sender as! NSIndexPath)
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChooseCourseTableViewCell
            let navigationController = segue.destinationViewController as? UINavigationController
            let destinationVC = navigationController!.topViewController as! CourseDetailsViewController
            destinationVC.courseNameReceived = courseNameForSegue
        }
        
        if (segue.identifier == "toChooseDateSegue") {
            let destinationVC = segue.destinationViewController as! ChooseDateViewController
            destinationVC.courseNameReceived = courseNameForSegue
            destinationVC.courseLocationReceived = courseLocationForSegue
            destinationVC.coursePriceReceived = coursePriceForSegue
        }
    }
    

}
