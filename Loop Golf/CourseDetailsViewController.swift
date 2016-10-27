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
        
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.black]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "GolfCourseImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        if (courseNameReceived != "") {
            courseNameLabel.text = courseNameReceived!
        }
        
        if (courseIsAFavorite == true) {
            favoriteBarButtonItem.image = UIImage(named: "LikeIconFilled")
        } else {
            favoriteBarButtonItem.image = UIImage(named: "LikeIconUnfilled")
        }
        
        favoritesNotificationView.layer.cornerRadius = 8
        favoritesNotificationView.layer.shadowColor = UIColor.black.cgColor
        favoritesNotificationView.layer.shadowOpacity = 0.5
        favoritesNotificationView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        favoritesNotificationView.layer.isHidden = true
        
    }
}

extension CourseDetailsViewController {
    
    @IBAction func dismissVCButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
        
    }
    
    @IBAction func favoriteBarButtonPressed(_ sender: UIBarButtonItem) {
        favoritesNotificationView.isHidden = false
        
        if (courseIsAFavorite == true) {
            removeFromFavorites()
        } else {
            addToFavorites()
        }
    }
    
    func addToFavorites() {
        favoritesNotificationLabel.text = "Course added to Favorites"
        favoritesNotificationImage.image = UIImage(named: "LikeIconFilled")
        
        UIView.animate(withDuration: 0.3, delay: 1.0, options: .curveEaseOut , animations: {
            self.favoritesNotificationView.alpha = 0
            }, completion: { finised in
                self.favoritesNotificationView.isHidden = true
                self.favoritesNotificationView.alpha = 1.0
        })
        favoriteBarButtonItem.image = UIImage(named: "LikeIconFilled")
        courseIsAFavorite = true
    }
    
    func removeFromFavorites() {
        favoritesNotificationLabel.text = "Course removed from Favorites"
        favoritesNotificationImage.image = UIImage(named: "LikeIconUnfilled")
        
        UIView.animate(withDuration: 0.3, delay: 1.0, options: .curveEaseOut , animations: {
            self.favoritesNotificationView.alpha = 0
            }, completion: { finised in
                self.favoritesNotificationView.isHidden = true
                self.favoritesNotificationView.alpha = 1.0
        })
        favoriteBarButtonItem.image = UIImage(named: "LikeIconUnfilled")
        courseIsAFavorite = false
    }
    
}
