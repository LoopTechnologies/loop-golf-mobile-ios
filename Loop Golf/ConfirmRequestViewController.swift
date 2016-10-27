//
//  ConfirmRequestViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/6/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ConfirmRequestViewController: UIViewController {
    
    @IBOutlet weak var navBarShadowView: UIView!
    @IBOutlet weak var confirmRequestButton: UIButton!
    @IBOutlet weak var bottomBarView: UIView!
    
    // Receive data via segue.
    var courseNameReceivedTwice: String?
    var courseLocationReceivedTwice: String?
    var coursePriceReceivedTwice: Int?
    var selectedDateTimeStringReceivedAgain: String?
    var selectedFullStyleDateReceivedAgain: String?
    var selected12HrTimeStringReceivedAgain: String?
    var caddieNameReceived: String?
    var acceptanceRateReceived: Int?
    
    // Send data to child VC via segue.
    var courseNameForChild = String()
    var courseLocationForChild = String()
    var coursePriceForChild = Int()
    var dateTimeStringForChild = String()
    var fullStyleDateForChild = String()
    var selected12HrTimeStringForChild = String()
    var caddieNameForChild = String()
    var acceptanceRateForChild = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Confirm Request"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "GolfCourseImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        navBarShadowView.layer.shadowColor = UIColor.black.cgColor
        navBarShadowView.layer.shadowOpacity = 0.5
        navBarShadowView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        bottomBarView.layer.shadowColor = UIColor.black.cgColor
        bottomBarView.layer.shadowOpacity = 0.5
        bottomBarView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        confirmRequestButton.layer.cornerRadius = 8
        

    }
}

extension ConfirmRequestViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        courseNameForChild = courseNameReceivedTwice!
        courseLocationForChild = courseLocationReceivedTwice!
        coursePriceForChild = coursePriceReceivedTwice!
        dateTimeStringForChild = selectedDateTimeStringReceivedAgain!
        fullStyleDateForChild = selectedFullStyleDateReceivedAgain!
        selected12HrTimeStringForChild = selected12HrTimeStringReceivedAgain!
        caddieNameForChild = caddieNameReceived!
        acceptanceRateForChild = acceptanceRateReceived!
        
        if (segue.identifier == "confirmRequestContainerSegue") {
            let confirmRequestContainer = segue.destination as! ConfirmRequestContainerViewController
            
            confirmRequestContainer.courseNameReceived = courseNameForChild
            confirmRequestContainer.courseLocationReceived = courseLocationForChild
            confirmRequestContainer.coursePriceReceived = coursePriceForChild
            confirmRequestContainer.dateTimeStringReceived = dateTimeStringForChild
            confirmRequestContainer.fullStyleDateReceived = fullStyleDateForChild
            confirmRequestContainer.timeStringReceived = selected12HrTimeStringForChild
            confirmRequestContainer.caddieNameReceived = caddieNameForChild
            confirmRequestContainer.acceptanceRateReceived = acceptanceRateForChild
        }
    }

    
    @IBAction func confirmButtonPressed(_ sender: AnyObject) {
        
        let alertController = UIAlertController(title: "See you on the course.", message:  "\n Reservation number: B4N89G3L \n \n Your request has been received and forwarded to your selected caddie, who has 12 hours to respond. \n \n If confirmed by your caddie, your request will become a reservation and we'll send you future reminders as the date and time of your golf round approaches.", preferredStyle: .alert)
        alertController.view.tintColor = UIColor.black
        let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.closeAllReservationProcesses()
        }
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true) {
            alertController.view.tintColor = UIColor.black
        }
    }
    
    // Implement unwind segue method in the future.
    func closeAllReservationProcesses() {
        self.presentingViewController!.dismiss(animated: true, completion: {})
        
    }
    
}
