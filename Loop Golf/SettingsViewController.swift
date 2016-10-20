//
//  SettingsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var locationServicesCell: UITableViewCell!
    @IBOutlet weak var locationServicesStatusLabel: UILabel!
    @IBOutlet weak var notificationsCell: UITableViewCell!
    @IBOutlet weak var notificationsStatusLabel: UILabel!
    @IBOutlet weak var sendFeedbackCell: UITableViewCell!
    @IBOutlet weak var goToWebsiteCell: UITableViewCell!
    @IBOutlet weak var likeOnFacebookCell: UITableViewCell!
    @IBOutlet weak var rateInAppStoreCell: UITableViewCell!
    @IBOutlet weak var signOutCell: UITableViewCell!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        displayLocationServicesStatusLabel()
        displayNotificationsStatusLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
    }
}

extension SettingsViewController {
    
    func displayLocationServicesStatusLabel() {
        if ((appDelegate.locationServicesEnabled)! == true) {
            locationServicesStatusLabel.text = "Enabled"
            locationServicesStatusLabel.textColor = UIColor.darkGrayColor()
        } else if ((appDelegate.locationServicesEnabled)! == false) {
            locationServicesStatusLabel.text = "Disabled"
            locationServicesStatusLabel.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    func displayNotificationsStatusLabel() {
        if ((appDelegate.notificationsEnabled)! == true) {
            notificationsStatusLabel.text = "Enabled"
            notificationsStatusLabel.textColor = UIColor.darkGrayColor()
        } else if ((appDelegate.notificationsEnabled)! == false) {
            notificationsStatusLabel.text = "Disabled"
            notificationsStatusLabel.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    @IBAction func dismissSettingsButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // User selects Location Services cell.
        if (cell == locationServicesCell) {
            let locServicesAlertController = UIAlertController(title: "Location Services - Required", message: "Your device's location is used to show nearby courses and track reservations. Required to use Loop Golf (you must have location services enabled to reserve caddies).", preferredStyle: .Alert)
            locServicesAlertController.view.tintColor = UIColor.blackColor()
            let locServicesSettingsAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(appSettings)
                }
            }
            locServicesAlertController.addAction(locServicesSettingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
            locServicesAlertController.addAction(cancelAction)
            presentViewController(locServicesAlertController, animated: true) {
                locServicesAlertController.view.tintColor = UIColor.blackColor()
            }
        }
        
        // User selects Notifications cell.
        if (cell == notificationsCell) {
            let notificationsAlertController = UIAlertController(title: "Push Notifications - Recommended", message: "Receive push notifications about responses to requests, upcoming reservations, new connections, and more. Suggested for an improved experience with Loop Golf.", preferredStyle: .Alert)
            notificationsAlertController.view.tintColor = UIColor.blackColor()
            let notificationSettingsAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(appSettings)
                }
            }
            notificationsAlertController.addAction(notificationSettingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in }
            notificationsAlertController.addAction(cancelAction)
            presentViewController(notificationsAlertController, animated: true) {
                notificationsAlertController.view.tintColor = UIColor.blackColor()
            }
        }
        
        // User selects Send Feedback cell.
        if (cell == sendFeedbackCell) {
            
        }
        
        // User selects Go To LoopGolf.com cell.
        if (cell == goToWebsiteCell) {
            
        }
        
        // User selects Like On Facebook cell.
        if (cell == likeOnFacebookCell) {
            
        }
        
        // User selects Rate In App Store cell.
        if (cell == rateInAppStoreCell) {
            
        }
        
        // User selects Sign Out cell.
        if (cell == signOutCell) {
            let actionSheetController = UIAlertController(title: "Are you sure you want to sign out?", message: "", preferredStyle: .ActionSheet)
            actionSheetController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            let signOutAction = UIAlertAction(title: "Sign Out", style: .Destructive) { (action) in
                
                /*
                if FIRAuth.auth()?.currentUser != nil {
                    do {
                        try FIRAuth.auth()?.signOut()
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
                self.presentViewController(loginViewController, animated: true, completion: nil)*/
            }
            actionSheetController.addAction(signOutAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            }
            actionSheetController.addAction(cancelAction)
            presentViewController(actionSheetController, animated: true) {
                actionSheetController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
            }

        }
    }
}
