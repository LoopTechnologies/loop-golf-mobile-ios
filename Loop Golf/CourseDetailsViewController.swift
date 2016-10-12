//
//  CourseDetailsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/4/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class CourseDetailsViewController: UIViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var courseIsAFavorite = false
    // --------------------------------------------------------------------------------//
    
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var favoritesNotificationView: UIView!
    @IBOutlet weak var favoritesNotificationLabel: UILabel!
    @IBOutlet weak var favoritesNotificationImage: UIImageView!
    
    
    // Receive data via segue.
    var courseNameReceived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "GolfCourseImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        if (courseNameReceived != "") {
            courseNameLabel.text = courseNameReceived!
        }
        
        if (courseIsAFavorite == true) {
            favoriteBarButtonItem.image = UIImage(named: "LikeIconFilled")
        } else {
            favoriteBarButtonItem.image = UIImage(named: "LikeIconUnfilled")
        }
        
        favoritesNotificationView.layer.cornerRadius = 8
        favoritesNotificationView.layer.shadowColor = UIColor.blackColor().CGColor
        favoritesNotificationView.layer.shadowOpacity = 0.5
        favoritesNotificationView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        favoritesNotificationView.layer.hidden = true
        
    }
}

extension CourseDetailsViewController {
    
    @IBAction func dismissVCButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
    @IBAction func favoriteBarButtonPressed(sender: UIBarButtonItem) {
        favoritesNotificationView.hidden = false
        
        if (courseIsAFavorite == true) {
            removeFromFavorites()
        } else {
            addToFavorites()
        }
    }
    
    func addToFavorites() {
        favoritesNotificationLabel.text = "Course added to Favorites"
        favoritesNotificationImage.image = UIImage(named: "LikeIconFilled")
        
        UIView.animateWithDuration(0.3, delay: 1.0, options: .CurveEaseOut , animations: {
            self.favoritesNotificationView.alpha = 0
            }, completion: { finised in
                self.favoritesNotificationView.hidden = true
                self.favoritesNotificationView.alpha = 1.0
        })
        favoriteBarButtonItem.image = UIImage(named: "LikeIconFilled")
        courseIsAFavorite = true
    }
    
    func removeFromFavorites() {
        favoritesNotificationLabel.text = "Course removed from Favorites"
        favoritesNotificationImage.image = UIImage(named: "LikeIconUnfilled")
        
        UIView.animateWithDuration(0.3, delay: 1.0, options: .CurveEaseOut , animations: {
            self.favoritesNotificationView.alpha = 0
            }, completion: { finised in
                self.favoritesNotificationView.hidden = true
                self.favoritesNotificationView.alpha = 1.0
        })
        favoriteBarButtonItem.image = UIImage(named: "LikeIconUnfilled")
        courseIsAFavorite = false
    }
    
}
