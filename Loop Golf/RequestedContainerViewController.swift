//
//  RequestedContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class RequestedContainerViewController: UITableViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var caddieNames = ["Mark Thompson", "Tom Donald"]
    var courseNames = ["Hearthstone Country Club", "Cypresswood Golf Club"]
    var courseLocations = ["Cypress, Texas", "Spring, Texas"]
    var dates = ["November 5, 2016", "November 20, 2016"]
    var times = ["12:05 PM", "3:20 PM"]
    var status = ["p", "d"]
    // --------------------------------------------------------------------------------//
    
    // Send data via segue.
    var segueSender = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clearColor()
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
    }
}

extension RequestedContainerViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 129
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (caddieNames.count > 0) {
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
        return caddieNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ReservationsTableViewCell
        
        cell.caddieNameLabel.text = caddieNames[indexPath.row] as? String
        cell.courseNameLabel.text = courseNames[indexPath.row] as? String
        cell.courseLocationLabel.text = courseLocations[indexPath.row] as? String
        cell.reservationDateLabel.text = "\(dates[indexPath.row]) at \(times[indexPath.row])" as? String
        cell.statusLabel.layer.borderWidth = 1
        cell.statusLabel.layer.cornerRadius = 8
        
        if (status[indexPath.row] == "p") {
            // Pending request.
            cell.statusLabel.text = "PENDING"
            cell.statusLabel.textColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
            cell.statusLabel.layer.borderColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0).CGColor
        } else if (status[indexPath.row] == "d") {
            // Declined request.
            cell.statusLabel.text = "DECLINED"
            cell.statusLabel.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
            cell.statusLabel.layer.borderColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).CGColor
        }

        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ReservationsTableViewCell
        cell.layer.cornerRadius = 8
        cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        
        if (status[indexPath.row] == "p") {
            segueSender = 0
        } else if (status[indexPath.row] == "d") {
            segueSender = 1
        }
        
        performSegueWithIdentifier("toRequestSegue", sender: self)
        
        UIView.animateWithDuration(0.1, delay: 0.5, options: .CurveLinear, animations: {
            cell.backgroundColor =  UIColor.blackColor().colorWithAlphaComponent(0)
            }, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toRequestSegue") {
            
            let destinationVC = segue.destinationViewController as! ReservationPopoverViewController
            destinationVC.senderReceived = segueSender
        }
    }
}
