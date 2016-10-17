//
//  ReservationPopoverViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/14/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ReservationPopoverViewController: UIViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var otherGolfers = []
    
    // --------------------------------------------------------------------------------//

    
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var requestedReservationContainer: UIView!
    @IBOutlet weak var confirmedReservationContainer: UIView!
    
    // Receive data via segue.
    var senderReceived: Int?
    
    // Send data to child VCs via segue.
    var otherGolfersForSegue = [String]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch (senderReceived!) {
        case 0:
            navigationBar.topItem!.title = "Pending Request"
            requestedReservationContainer.hidden = false
            confirmedReservationContainer.hidden = true
        case 1:
            navigationBar.topItem!.title = "Declined Request"
            requestedReservationContainer.hidden = false
            confirmedReservationContainer.hidden = true
        case 2:
            navigationBar.topItem!.title = "Confirmed Reservation"
            requestedReservationContainer.hidden = true
            confirmedReservationContainer.hidden = false
        default:
            break
        }
    
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-DemiBold", size: 22)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        popoverView.layer.cornerRadius = 8

    }
}

extension ReservationPopoverViewController {
    
    @IBAction func dismissVCButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
    @IBAction func backgroundPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "requestedReservationDetailsSegue") {
            let destinationVC = segue.destinationViewController as! RequestedReservationDetailsViewController
            destinationVC.typeOfReservationReceived = senderReceived!
        }
        
        if (segue.identifier == "confirmedReservationDetailsSegue") {
            let destinationVC = segue.destinationViewController as! ConfirmedReservationDetailsViewController
            otherGolfersForSegue = otherGolfers as! [String]
            
            destinationVC.typeOfReservationReceived = senderReceived!
            destinationVC.otherGolfersReceived = otherGolfersForSegue
        }
    }
    
    
}
