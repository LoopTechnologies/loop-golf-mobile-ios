//
//  ChooseCaddieViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/5/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ChooseCaddieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var caddieNames = ["Jerry Marshall", "Tyler Dalton", "Brandon Smith", "Reed Winters"]
    var acceptanceRate = [85, 98, 90, 92]
    
    var sunAvailability = [true, false, true, false]
    var monAvailability = [true, true, false, true]
    var tueAvailability = [true, true, false, false]
    var wedAvailability = [true, true, false, true]
    var thuAvailability = [true, true, false, false]
    var friAvailability = [true, true, true, false]
    var satAvailability = [true, false, false, true]

    
    var golfKnowledge = [4.5, 4.2, 4.9, 3.8]
    var greenReading = [4.7, 4.4, 5.0, 4.2]
    var customerSatisfaction = [4.3, 4.6, 4.8, 4.1]
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarShadowView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseLocationLabel: UILabel!
    @IBOutlet weak var resDateTimeLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var firstCircle: UIView!
    @IBOutlet weak var secondCircle: UIView!
    @IBOutlet weak var thirdCircle: UIView!
    
    let timeFormatter12Hr = NSDateFormatter()
    var timeNSDate = NSDate()
    let dateFormatter = NSDateFormatter()
    var dateNSDate = NSDate()
    
    // Receive data via segue.
    var courseIDReceived: String?
    var courseNameReceivedAgain: String?
    var courseLocationReceivedAgain: String?
    var selectedDateTimeStringReceived: String?
    var selectedFullStyleDateReceived: String?
    var selected12HrTimeStringReceived: String?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        
        navigationItem.title = "Nearby Caddies"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()        
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        navBarShadowView.layer.shadowColor = UIColor.blackColor().CGColor
        navBarShadowView.layer.shadowOpacity = 0.5
        navBarShadowView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        topBarView.layer.shadowColor = UIColor.blackColor().CGColor
        topBarView.layer.shadowOpacity = 0.5
        topBarView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        firstCircle.layer.borderWidth = 2
        firstCircle.layer.borderColor = UIColor.blackColor().CGColor
        firstCircle.layer.cornerRadius = 15
        
        secondCircle.layer.borderWidth = 2
        secondCircle.layer.borderColor = UIColor.blackColor().CGColor
        secondCircle.layer.cornerRadius = 15
        
        thirdCircle.layer.borderWidth = 2
        thirdCircle.layer.borderColor = UIColor.blackColor().CGColor
        thirdCircle.layer.cornerRadius = 15

        
        courseNameLabel.text = courseNameReceivedAgain!
        
        courseLocationLabel.text = courseLocationReceivedAgain!
        
        resDateTimeLabel.text = "\(selectedFullStyleDateReceived!) at \(selected12HrTimeStringReceived!)"
    }
}

extension ChooseCaddieViewController {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 190
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (caddieNames.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
            noDataLabel.text = "Unfortunately no caddies appear to be available for your selected course, date, and time."
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caddieNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CaddieTableViewCell
        
        cell.cellBackgroundView.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6).CGColor
        cell.cellBackgroundView.layer.cornerRadius = 8
        
        cell.profileImageView.image = UIImage(named: "DefaultProfileImage")
        cell.profileImageView.layer.cornerRadius = 40
        
        cell.nameLabel.text = caddieNames[indexPath.row]
        cell.acceptanceRateLabel.text = "\(acceptanceRate[indexPath.row])% of requests accepted"
        
        
        if (sunAvailability[indexPath.row] == true) {
            cell.sunAvailabilityLabel.textColor = UIColor.whiteColor()
            cell.sunAvailabilityLabel.font = UIFont.boldSystemFontOfSize(14)
        }
        
        if (monAvailability[indexPath.row] == true) {
            cell.monAvailabilityLabel.textColor = UIColor.whiteColor()
            cell.monAvailabilityLabel.font = UIFont.boldSystemFontOfSize(14)
        }
        
        if (tueAvailability[indexPath.row] == true) {
            cell.tueAvailabilityLabel.textColor = UIColor.whiteColor()
            cell.tueAvailabilityLabel.font = UIFont.boldSystemFontOfSize(14)
        }
        
        if (wedAvailability[indexPath.row] == true) {
            cell.wedAvailabilityLabel.textColor = UIColor.whiteColor()
            cell.wedAvailabilityLabel.font = UIFont.boldSystemFontOfSize(14)
        }
        
        if (thuAvailability[indexPath.row] == true) {
            cell.thuAvailabilityLabel.textColor = UIColor.whiteColor()
            cell.thuAvailabilityLabel.font = UIFont.boldSystemFontOfSize(14)
        }
        
        if (friAvailability[indexPath.row] == true) {
            cell.friAvailabilityLabel.textColor = UIColor.whiteColor()
            cell.friAvailabilityLabel.font = UIFont.boldSystemFontOfSize(14)
        }
        
        if (satAvailability[indexPath.row] == true) {
            cell.satAvailabilityLabel.textColor = UIColor.whiteColor()
            cell.satAvailabilityLabel.font = UIFont.boldSystemFontOfSize(14)
        }
        
        cell.golfKnowledgeRatingLabel.text = "\(golfKnowledge[indexPath.row])"
        cell.greenReadingRatingLabel.text = "\(greenReading[indexPath.row])"
        cell.customerSatisfactionRatingLabel.text = "\(customerSatisfaction[indexPath.row])"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CaddieTableViewCell
        cell.cellBackgroundView.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8).CGColor
        
        performSegueWithIdentifier("toConfirmReservationSegue", sender: self)
        
        UIView.animateWithDuration(0.1, delay: 0.5, options: .CurveLinear, animations: {
            cell.cellBackgroundView.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6).CGColor
        }, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "toConfirmReservationSegue") {
            
        }
    }
}
