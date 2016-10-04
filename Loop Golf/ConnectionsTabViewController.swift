//
//  ConnectionsTabViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/2/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ConnectionsTabViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var addGolferBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var caddiesContainer: UIView!
    @IBOutlet weak var golfersContainer: UIView!
    
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notifyWithSelectedIndex:", name: "selectedIndexNotification", object: nil)
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        roundedBackgroundView.layer.cornerRadius = 8
        showCaddiesContainer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "selectedIndexNotification", object: self.view.window)
    }
}

extension ConnectionsTabViewController {
    
    @IBAction func addGolferBarButtonItemPressed(sender: UIBarButtonItem) {
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func notifyWithSelectedIndex (notification: NSNotification) {
        selectedIndex = notification.object! as! Int
        
        switch (selectedIndex) {
        case 0:
            showCaddiesContainer()
        case 1:
            showGolfersContainer()
        default:
            break
        }
    }
    
    func showCaddiesContainer() {
        caddiesContainer.hidden = false
        golfersContainer.hidden = true
        addGolferBarButtonItem.enabled = false
        addGolferBarButtonItem.tintColor = UIColor.clearColor()
    }
    
    func showGolfersContainer() {
        caddiesContainer.hidden = true
        golfersContainer.hidden = false
        addGolferBarButtonItem.enabled = true
        addGolferBarButtonItem.tintColor = UIColor.whiteColor()
    }
}

