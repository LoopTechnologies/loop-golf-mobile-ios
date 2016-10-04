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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseNames = courseNamesReceived!
        courseLocations = courseLocationsReceived!
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        longPressRecognizer.minimumPressDuration = 0.35
        longPressRecognizer.delaysTouchesBegan = true
        longPressRecognizer.delegate = self
        self.tableView?.addGestureRecognizer(longPressRecognizer)
        
    }
}

extension NearbyCoursesContainerViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
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
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChooseCourseTableViewCell
        
    }
    
    func handleLongPress(gestureRecognizer: UIGestureRecognizer) {
        if (gestureRecognizer.state != .Began) {
            return
        }
        let touchPoint = gestureRecognizer.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(touchPoint)
        
        if let index = indexPath {
            var cell = self.tableView?.cellForRowAtIndexPath(index) as! ChooseCourseTableViewCell
            //selectedCourseNameToSend = nearbyCourseNamesToDisplay[index.row]
            performSegueWithIdentifier("nearbyCourseDetailsSegue", sender: indexPath)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "nearbyCourseDetailsSegue") {
            var indexPath: NSIndexPath = (sender as! NSIndexPath)
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ChooseCourseTableViewCell
            let navigationController = segue.destinationViewController as? UINavigationController
            let destinationVC = navigationController!.topViewController as! CourseDetailsViewController
        }
    }
    
}

