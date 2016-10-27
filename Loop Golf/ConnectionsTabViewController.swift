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
        NotificationCenter.default.addObserver(self, selector: #selector(ConnectionsTabViewController.notifyWithSelectedIndex(_:)), name: NSNotification.Name(rawValue: "selectedIndexNotification"), object: nil)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.white]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        roundedBackgroundView.layer.cornerRadius = 8
        showCaddiesContainer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "selectedIndexNotification"), object: self.view.window)
    }
}

extension ConnectionsTabViewController {
    
    @IBAction func addGolferBarButtonItemPressed(_ sender: UIBarButtonItem) {
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func notifyWithSelectedIndex (_ notification: Notification) {
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
        caddiesContainer.isHidden = false
        golfersContainer.isHidden = true
        addGolferBarButtonItem.isEnabled = false
        addGolferBarButtonItem.tintColor = UIColor.clear
    }
    
    func showGolfersContainer() {
        caddiesContainer.isHidden = true
        golfersContainer.isHidden = false
        addGolferBarButtonItem.isEnabled = true
        addGolferBarButtonItem.tintColor = UIColor.white
    }
}

