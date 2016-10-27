//
//  ChooseCourseViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ChooseCourseViewController: UIViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var courseNames = ["Memorial Park Golf Course", "Wildcat Golf Club", "The Club at Falcon Point", "Black Hawk Country Club", "The Club at Carlton Woods Creekside"]
    var courseLocations = ["Houston, Texas", "Houston, Texas", "Katy, Texas", "Richmond, Texas", "The Woodlands, Texas"]
    var courseDistances = [1.4, 9.7, 21.9, 28.2, 34.3]
    var coursePrices = [62, 68, 78, 82, 94]
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var segmentedControlBackgroundView: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var firstCircle: UIView!
    @IBOutlet weak var secondCircle: UIView!
    @IBOutlet weak var thirdCircle: UIView!
    @IBOutlet weak var nearbyCoursesContainer: UIView!
    @IBOutlet weak var favoriteCoursesContainer: UIView!
    
    var selectedIndex = Int()
    
    // Send data to child VC via segue.
    var courseNamesForChild = [String]()
    var courseLocationsForChild = [String]()
    var courseDistancesForChild = [Double]()
    var coursePricesForChild = [Int]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.black]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChooseCourseViewController.notifyWithSelectedIndex(_:)), name: NSNotification.Name(rawValue: "selectedIndexNotification"), object: nil)

        segmentedControlBackgroundView.layer.shadowColor = UIColor.black.cgColor
        segmentedControlBackgroundView.layer.shadowOpacity = 0.5
        segmentedControlBackgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        progressBarView.layer.shadowColor = UIColor.black.cgColor
        progressBarView.layer.shadowOpacity = 0.5
        progressBarView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        firstCircle.layer.borderWidth = 2
        firstCircle.layer.borderColor = UIColor.black.cgColor
        firstCircle.layer.cornerRadius = 15
        
        secondCircle.layer.borderWidth = 1
        secondCircle.layer.borderColor = UIColor.lightGray.cgColor
        secondCircle.layer.cornerRadius = 15
        
        thirdCircle.layer.borderWidth = 1
        thirdCircle.layer.borderColor = UIColor.lightGray.cgColor
        thirdCircle.layer.cornerRadius = 15
        
        favoriteCoursesContainer.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "selectedIndexNotification"), object: self.view.window)
    }
}

extension ChooseCourseViewController {
    
    func notifyWithSelectedIndex (_ notification: Notification) {
        selectedIndex = notification.object! as! Int
        
        switch (selectedIndex) {
        case 0:
            nearbyCoursesContainer.isHidden = false
            favoriteCoursesContainer.isHidden = true
        case 1:
            nearbyCoursesContainer.isHidden = true
            favoriteCoursesContainer.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func dismissVCButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        courseNamesForChild = courseNames
        courseLocationsForChild = courseLocations
        courseDistancesForChild = courseDistances
        coursePricesForChild = coursePrices

        if (segue.identifier == "nearbyCoursesContainerSegue") {
            let nearbyCoursesContainer = segue.destination as! NearbyCoursesContainerViewController
            nearbyCoursesContainer.courseNamesReceived = courseNamesForChild
            nearbyCoursesContainer.courseLocationsReceived = courseLocationsForChild
            nearbyCoursesContainer.courseDistancesReceived = courseDistancesForChild
            nearbyCoursesContainer.coursePricesReceived = coursePricesForChild
        }
        
        if (segue.identifier == "favoriteCoursesContainerSegue") {
            let favoriteCoursesContainer = segue.destination as! FavoriteCoursesContainerViewController
            favoriteCoursesContainer.courseNamesReceived = courseNamesForChild
            favoriteCoursesContainer.courseLocationsReceived = courseLocationsForChild
            favoriteCoursesContainer.courseDistancesReceived = courseDistancesForChild
            favoriteCoursesContainer.coursePricesReceived = coursePricesForChild
        }
    }
    
}
