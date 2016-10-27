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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        displayLocationServicesStatusLabel()
        displayNotificationsStatusLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.black]
    }
}

extension SettingsViewController {
    
    func displayLocationServicesStatusLabel() {
        if ((appDelegate.locationServicesEnabled)! == true) {
            locationServicesStatusLabel.text = "Enabled"
            locationServicesStatusLabel.textColor = UIColor.darkGray
        } else if ((appDelegate.locationServicesEnabled)! == false) {
            locationServicesStatusLabel.text = "Disabled"
            locationServicesStatusLabel.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    func displayNotificationsStatusLabel() {
        if ((appDelegate.notificationsEnabled)! == true) {
            notificationsStatusLabel.text = "Enabled"
            notificationsStatusLabel.textColor = UIColor.darkGray
        } else if ((appDelegate.notificationsEnabled)! == false) {
            notificationsStatusLabel.text = "Disabled"
            notificationsStatusLabel.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    @IBAction func dismissSettingsButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        // User selects Location Services cell.
        if (cell == locationServicesCell) {
            let locServicesAlertController = UIAlertController(title: "Location Services - Required", message: "Your device's location is used to show nearby courses and track reservations. Required to use Loop Golf (you must have location services enabled to reserve caddies).", preferredStyle: .alert)
            locServicesAlertController.view.tintColor = UIColor.black
            let locServicesSettingsAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(appSettings)
                }
            }
            locServicesAlertController.addAction(locServicesSettingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
            locServicesAlertController.addAction(cancelAction)
            present(locServicesAlertController, animated: true) {
                locServicesAlertController.view.tintColor = UIColor.black
            }
        }
        
        // User selects Notifications cell.
        if (cell == notificationsCell) {
            let notificationsAlertController = UIAlertController(title: "Push Notifications - Recommended", message: "Receive push notifications about responses to requests, upcoming reservations, new connections, and more. Suggested for an improved experience with Loop Golf.", preferredStyle: .alert)
            notificationsAlertController.view.tintColor = UIColor.black
            let notificationSettingsAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(appSettings)
                }
            }
            notificationsAlertController.addAction(notificationSettingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
            notificationsAlertController.addAction(cancelAction)
            present(notificationsAlertController, animated: true) {
                notificationsAlertController.view.tintColor = UIColor.black
            }
        }
        
        // User selects Send Feedback cell.
        if (cell == sendFeedbackCell) {
            
        }
        
        // User selects Go To LoopGolf.com cell.
        if (cell == goToWebsiteCell) {
            UIApplication.shared.openURL(URL(string: "http://www.loopgolf.com")!)
        }
        
        // User selects Like On Facebook cell.
        if (cell == likeOnFacebookCell) {
            UIApplication.shared.openURL(URL(string: "http://www.facebook.com")!)
        }
        
        // User selects Rate In App Store cell.
        if (cell == rateInAppStoreCell) {
            
        }
        
        // User selects Sign Out cell.
        if (cell == signOutCell) {
            let actionSheetController = UIAlertController(title: "Are you sure you want to sign out?", message: "\n There's really no need to leave.", preferredStyle: .actionSheet)
            actionSheetController.view.tintColor = UIColor.black
            let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
                
                /*
                if FIRAuth.auth()?.currentUser != nil {
                    do {
                        try FIRAuth.auth()?.signOut()
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
                */
 
 
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(loginViewController, animated: true, completion: nil)
            }
            actionSheetController.addAction(signOutAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            actionSheetController.addAction(cancelAction)
            present(actionSheetController, animated: true) {
                actionSheetController.view.tintColor = UIColor.black
            }

        }
    }
}
