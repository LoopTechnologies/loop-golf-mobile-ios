//
//  CaddiesContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class CaddiesContainerViewController: UITableViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var caddieNames = ["Harrison Barnes", "Tommy McMuffin"]
    var caddieHistory = ["August 2016","September 2016"]
    
    
    // --------------------------------------------------------------------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clearColor()
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
        
    }
}

extension CaddiesContainerViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 57
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (caddieNames.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "You haven't golfed with any Loop caddies. Caddie connections are added after completing rounds of golf."
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ConnectionsTableViewCell
        
        cell.nameLabel.text = caddieNames[indexPath.row] as? String
        cell.secondaryLabel.text = "Last caddied for you \(caddieHistory[indexPath.row])"

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ConnectionsTableViewCell
        cell.layer.cornerRadius = 8
        cell.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
    }
}
