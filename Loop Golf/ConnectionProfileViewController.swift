//
//  ConnectionProfileViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/12/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ConnectionProfileViewController: UIViewController {
    
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var reserveAgainButton: UIButton!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileSecondaryLabel: UILabel!
    @IBOutlet weak var profileSecondaryButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var textMessageButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    
    // Receive data via segue.
    var senderReceived: Int?
    var profileNameReceived: String?
    var profileSecondaryInfoReceived: String?
    
    var connectionType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        popoverView.layer.cornerRadius = 8
        reserveAgainButton.layer.cornerRadius = 8
        profileSecondaryButton.layer.cornerRadius = 15
        
        profileNameLabel.text = profileNameReceived!
        
        if (senderReceived! == 1) {
            profileSecondaryLabel.text = "Member since \(profileSecondaryInfoReceived!)"
            profileSecondaryButton.setTitle("   Rate this caddie   ", forState: .Normal)
            reserveAgainButton.hidden = false
            callButton.hidden = true
            textMessageButton.hidden = true
            emailButton.hidden = true
            connectionType = "caddie"
        } else if (senderReceived! == 2) {
            profileSecondaryLabel.text = "@\(profileSecondaryInfoReceived!)"
            profileSecondaryButton.setTitle("   Block this user   ", forState: .Normal)
            reserveAgainButton.hidden = true
            callButton.hidden = false
            textMessageButton.hidden = false
            emailButton.hidden = false
            connectionType = "golfer"
        }
    }
    
}

extension ConnectionProfileViewController {
    
    @IBAction func dismissVCButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
    @IBAction func backgroundPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func deleteBarButtonPressed(sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Remove this connection?", message:  "This \(connectionType) will be deleted from your list of connections.", preferredStyle: .ActionSheet)
        actionSheet.view.tintColor = UIColor.blackColor()
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        actionSheet.addAction(cancelAction)
        let removeAction = UIAlertAction(title: "Remove", style: .Destructive) { (action) in
        }
        actionSheet.addAction(removeAction)
        self.presentViewController(actionSheet, animated: true) {
            actionSheet.view.tintColor = UIColor.blackColor()
        }
    }
    
    
    
}
