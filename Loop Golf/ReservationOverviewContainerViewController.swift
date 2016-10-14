//
//  ReservationOverviewContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/14/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ReservationOverviewContainerViewController: UITableViewController {
    
    @IBOutlet weak var reservingGolferNameLabel: UILabel!
    @IBOutlet weak var golfer1Cell: UITableViewCell!
    @IBOutlet weak var requestNotificationLabel: UILabel!
    @IBOutlet weak var golfer1NameLabel: UILabel!
    @IBOutlet weak var golfer1RemoveButton: UIButton!
    @IBOutlet weak var golfer2Cell: UITableViewCell!
    @IBOutlet weak var golfer2NameLabel: UILabel!
    @IBOutlet weak var golfer3Cell: UITableViewCell!
    @IBOutlet weak var golfer3NameLabel: UILabel!
    
    
    // Receive data from parent VC via segue.
    var typeOfReservationReceived: Int?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        switch (typeOfReservationReceived!) {
        case 0:
            print("pending")
            formatTableViewForRequest()
        case 1:
            print("declined")
            formatTableViewForRequest()
        case 2:
            print("confirmed")
            formatTableViewForReservation()
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ReservationOverviewContainerViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func formatTableViewForRequest() {
        tableView.contentInset = UIEdgeInsetsMake(100, 0, -70, 0)
        reservingGolferNameLabel.text = "You"
        requestNotificationLabel.hidden = false
        golfer1NameLabel.hidden = true
        golfer1RemoveButton.hidden = true
        golfer2Cell.hidden = true
        golfer3Cell.hidden = true
    }
    
    func formatTableViewForReservation() {
        tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
        requestNotificationLabel.hidden = true

    }
}
