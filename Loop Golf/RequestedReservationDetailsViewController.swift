//
//  RequestedReservationDetailsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/14/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class RequestedReservationDetailsViewController: UITableViewController {
    
    @IBOutlet weak var selectNewButtonCell: UITableViewCell!
    @IBOutlet weak var requestStatusBannerLabel: UILabel!
    @IBOutlet weak var selectNewButton: UIButton!
    
    
    // Receive data from parent VC via segue.
    var typeOfReservationReceived: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectNewButton.layer.cornerRadius = 15
        
        switch (typeOfReservationReceived!) {
        case 0:
            print("pending")
            tableView.contentInset = UIEdgeInsetsMake(-60, 0, 10, 0)
            requestStatusBannerLabel.text = "Every caddie has 12 hours to respond to a reservation request. Your reservation will remain pending until it is confirmed or declined."
            selectNewButtonCell.hidden = true
        case 1:
            print("declined")
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
            requestStatusBannerLabel.text = "Unfortunately, your requested caddie is unable to complete your reservation. Don't worry though, finding another caddie is easy."
            selectNewButtonCell.hidden = false
        default:
            break
        }
    }
}

extension RequestedReservationDetailsViewController {
 
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
