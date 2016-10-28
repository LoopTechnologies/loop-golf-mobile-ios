//
//  ReservationsTabViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ReservationsTabViewController: UIViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    
    
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var requestedContainer: UIView!
    @IBOutlet weak var confirmedContainer: UIView!
    
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ReservationsTabViewController.notifyWithSelectedIndex(_:)), name: NSNotification.Name(rawValue: "selectedIndexNotification"), object: nil)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.white]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        confirmedContainer.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "selectedIndexNotification"), object: self.view.window)
    }
}

extension ReservationsTabViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    func notifyWithSelectedIndex (_ notification: Notification) {
        selectedIndex = notification.object! as! Int
        
        if (selectedIndex == 0) {
            requestedContainer.isHidden = false
            confirmedContainer.isHidden = true
        } else if (selectedIndex == 1) {
            requestedContainer.isHidden = true
            confirmedContainer.isHidden = false
        }
    }
}
