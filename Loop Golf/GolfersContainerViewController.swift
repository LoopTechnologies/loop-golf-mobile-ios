//
//  GolfersContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class GolfersContainerViewController: UITableViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var golferNames = ["Larry David", "Jackie Chan"]
    
    var userNames = ["larry-david", "jack-chan-2"]
    
    // --------------------------------------------------------------------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension GolfersContainerViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 57
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (golferNames.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "You don't have any golfer connections to show. Connect with your friends on Loop to start golfing together."
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
        return golferNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ConnectionsTableViewCell
        
        cell.nameLabel.text = golferNames[indexPath.row] as? String
        cell.secondaryLabel.text = "@\(userNames[indexPath.row])"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ConnectionsTableViewCell
        cell.layer.cornerRadius = 8
        cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
    }

}
