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
        
        if (senderReceived! == 1) {
            caddieContainer.hidden = false
            golferContainer.hidden = true
            connectionType = "caddie"
        } else if (senderReceived! == 2) {
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
    
    
    @IBAction func moreBarButtonPressed(sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Options for connections", message:  "\n You can report a golfer or caddie for unacceptable actions such as profanity or harrassment. If you decide to remove a connection, that person will be permanently deleted from your connections list.", preferredStyle: .ActionSheet)
        actionSheet.view.tintColor = UIColor.blackColor()
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        actionSheet.addAction(cancelAction)
        let reportAction = UIAlertAction(title:"Report this \(connectionType)", style: .Default) { (action) in
            if (self.senderReceived! == 1) {
                // Trigger action to report caddie.
            } else if (self.senderReceived! == 2) {
                // Trigger action to report golfer.
            }
        }
        actionSheet.addAction(reportAction)
        
        let removeAction = UIAlertAction(title: "Remove from connections", style: .Destructive) { (action) in
            if (self.senderReceived! == 1) {
                // Trigger action to remove caddie from connections.
            } else if (self.senderReceived! == 2) {
                // Trigger action to remove caddie from connections.
            }
        }
        actionSheet.addAction(removeAction)
        
        self.presentViewController(actionSheet, animated: true) {
            actionSheet.view.tintColor = UIColor.blackColor()
        }
    }
}
