//
//  ProfileTabViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ProfileTabViewController: UIViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var firstName = "Mark"
    var lastName = "Johnson"
    var username = "mark-johnson"
    var membershipHistory = "September 2016"
    var lifetimeRounds = 3
    var credit = 5
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var membershipHistoryLabel: UILabel!
    @IBOutlet weak var lifetimeRoundsLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.white]
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        profileImageView.layer.cornerRadius = 50
        nameLabel.text = "\(firstName) \(lastName)"
        usernameLabel.text = "@\(username)"
        membershipHistoryLabel.text = "Member since \(membershipHistory)"
        lifetimeRoundsLabel.text = "\(lifetimeRounds)"
        creditLabel.text = "$\(credit)"
    }
}

extension ProfileTabViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
}
