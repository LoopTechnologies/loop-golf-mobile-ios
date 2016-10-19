//
//  SettingsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var editProfileCell: UITableViewCell!
    @IBOutlet weak var favoriteCoursesCell: UITableViewCell!
    @IBOutlet weak var courseSearchRadiusCell: UITableViewCell!
    @IBOutlet weak var paymentsCell: UITableViewCell!
    @IBOutlet weak var enterPromoCodeCell: UITableViewCell!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
    }
}

extension SettingsViewController {
    
    @IBAction func dismissSettingsButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (cell == editProfileCell) {
            performSegueWithIdentifier("toEditProfileSegue", sender: self)
        }
    }
}
