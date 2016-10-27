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
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        popoverView.layer.cornerRadius = 8
        
        if (senderReceived! == 1) {
            caddieContainer.isHidden = false
            golferContainer.isHidden = true
            connectionType = "caddie"
        } else if (senderReceived! == 2) {
            caddieContainer.isHidden = true
            golferContainer.isHidden = false
            connectionType = "golfer"
        }
    }
    
}

extension ConnectionPopoverViewController {
    
    @IBAction func dismissVCButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
        
    }
    
    @IBAction func backgroundPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    }
    
    
    @IBAction func moreBarButtonPressed(_ sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Options for connections", message:  "\n You can report a golfer or caddie for unacceptable actions such as profanity or harrassment. If you decide to remove a connection, that person will be permanently deleted from your connections list.", preferredStyle: .actionSheet)
        actionSheet.view.tintColor = UIColor.black
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        actionSheet.addAction(cancelAction)
        let reportAction = UIAlertAction(title:"Report this \(connectionType)", style: .default) { (action) in
            if (self.senderReceived! == 1) {
                // Trigger action to report caddie.
            } else if (self.senderReceived! == 2) {
                // Trigger action to report golfer.
            }
        }
        actionSheet.addAction(reportAction)
        
        let removeAction = UIAlertAction(title: "Remove from connections", style: .destructive) { (action) in
            if (self.senderReceived! == 1) {
                // Trigger action to remove caddie from connections.
            } else if (self.senderReceived! == 2) {
                // Trigger action to remove caddie from connections.
            }
        }
        actionSheet.addAction(removeAction)
        
        self.present(actionSheet, animated: true) {
            actionSheet.view.tintColor = UIColor.black
        }
    }
}
