//
//  NearbyCoursesContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class NearbyCoursesContainerViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    var courseNamesReceived: [String]?
    var courseLocationsReceived: [String]?
    
    var courseNames = [String]()
    var courseLocations = [String]()
    
    // Send data via segue.
    var courseNameForSegue = String()
    var courseLocationForSegue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseNames = courseNamesReceived!
        courseLocations = courseLocationsReceived!
    }
}

extension NearbyCoursesContainerViewController {
    
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
            noDataLabel.text = "You don't have any requested reservations."
            noDataLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
            noDataLabel.textColor = UIColor.whiteColor()
            noDataLabel.textAlignment = NSTextAlignment.Center
            noDataLabel.numberOfLines = 0
            noDataLabel.lineBreakMode = .ByWordWrapping
            tableView.backgroundView = noDataLabel
            tableView.backgroundColor = UIColor.clearColor()
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
        cell.courseLocationLabel.text = courseLocations[indexPath.row] as? String
        
        cell.moreButton.layer.borderWidth = 1
        cell.moreButton.layer.borderColor = UIColor.blackColor().CGColor
        cell.moreButton.layer.cornerRadius = 8
        
        cell.favoriteButton.tag = indexPath.row
        cell.moreButton.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChooseCourseTableViewCell
        
        courseNameForSegue = courseNames[indexPath.row]
        courseLocationForSegue = courseLocations[indexPath.row]
        
        cell.imageCoverView.alpha =  0.5
        
        performSegueWithIdentifier("toChooseDateSegue", sender: self)
        
        UIView.animateWithDuration(0.1, delay: 0.5, options: .CurveLinear, animations: {
            cell.imageCoverView.alpha =  0.2
            }, completion: nil)
    }
    
    @IBAction func favoriteButtonPressed(sender: UIButton) {
        var favoriteButtonPosition = sender.convertPoint(CGPointZero, toView: self.tableView)
        var indexPath = self.tableView.indexPathForRowAtPoint(favoriteButtonPosition)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath!) as! ChooseCourseTableViewCell
        
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
        }
    }
    
}

