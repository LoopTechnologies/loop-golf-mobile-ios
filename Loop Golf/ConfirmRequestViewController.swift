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
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "GolfCourseImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        navBarShadowView.layer.shadowColor = UIColor.blackColor().CGColor
        navBarShadowView.layer.shadowOpacity = 0.5
        navBarShadowView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        bottomBarView.layer.shadowColor = UIColor.blackColor().CGColor
        bottomBarView.layer.shadowOpacity = 0.5
        bottomBarView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        confirmRequestButton.layer.cornerRadius = 8
        

    }
}

extension ConfirmRequestViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        courseNameForChild = courseNameReceivedTwice!
        courseLocationForChild = courseLocationReceivedTwice!
        coursePriceForChild = coursePriceReceivedTwice!
        dateTimeStringForChild = selectedDateTimeStringReceivedAgain!
        fullStyleDateForChild = selectedFullStyleDateReceivedAgain!
        selected12HrTimeStringForChild = selected12HrTimeStringReceivedAgain!
        caddieNameForChild = caddieNameReceived!
        acceptanceRateForChild = acceptanceRateReceived!
        
        if (segue.identifier == "confirmRequestContainerSegue") {
            let confirmRequestContainer = segue.destinationViewController as! ConfirmRequestContainerViewController
            
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

    
    @IBAction func confirmButtonPressed(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "See you on the course.", message:  "\n Reservation number: abcd1234 \n \n Your request has been received and forwarded to your selected caddie, who has 12 hours to respond. \n \n If confirmed by your caddie, your request will become a reservation and we'll send you future reminders as the date and time of your golf round approaches.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            self.closeAllReservationProcesses()
        }
        alertController.addAction(doneAction)
        
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    // Implement unwind segue method in the future.
    func closeAllReservationProcesses() {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: {})
        
    }
    
}
