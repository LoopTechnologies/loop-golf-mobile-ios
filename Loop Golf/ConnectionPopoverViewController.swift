//
//  ConnectionPopoverViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/12/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ConnectionPopoverViewController: UIViewController {
    
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var caddieContainer: UIView!
    @IBOutlet weak var golferContainer: UIView!

    
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
        //profileSecondaryButton.layer.cornerRadius = 15
        
        //profileNameLabel.text = profileNameReceived!
        
        if (senderReceived! == 1) {
            //profileSecondaryLabel.text = "Member since \(profileSecondaryInfoReceived!)"
            //profileSecondaryButton.setTitle("   Rate this caddie   ", forState: .Normal)
            caddieContainer.hidden = false
            golferContainer.hidden = true

            connectionType = "caddie"
        } else if (senderReceived! == 2) {
            //profileSecondaryLabel.text = "@\(profileSecondaryInfoReceived!)"
            //profileSecondaryButton.setTitle("   Add to reservation   ", forState: .Normal)
            caddieContainer.hidden = true
            golferContainer.hidden = false
            
            connectionType = "golfer"
        }
    }
    
}

extension ConnectionPopoverViewController {
    
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
