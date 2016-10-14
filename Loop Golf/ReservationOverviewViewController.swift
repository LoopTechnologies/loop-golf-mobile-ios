//
//  ReservationOverviewViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/14/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ReservationOverviewViewController: UIViewController {
    
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // Receive data via segue.
    var senderReceived: Int?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch (senderReceived!) {
        case 0:
            navigationBar.topItem!.title = "Pending Request"
        case 1:
            navigationBar.topItem!.title = "Declined Request"
        case 2:
            navigationBar.topItem!.title = "Confirmed Reservation"
        default:
            break
        }
    
        navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-DemiBold", size: 22)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.shadowImage = UIImage()
        
        popoverView.layer.cornerRadius = 8

    }
}

extension ReservationOverviewViewController {
    
    @IBAction func dismissVCButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
    @IBAction func backgroundPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "reservationOverviewContainerSegue") {
            let destinationVC = segue.destinationViewController as! ReservationOverviewContainerViewController
            destinationVC.typeOfReservationReceived = senderReceived!
        }
    }
    
    
}
