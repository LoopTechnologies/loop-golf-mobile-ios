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
    @IBOutlet weak var cancelRequestCell: UITableViewCell!
    
    
    
    // Receive data from parent VC via segue.
    var typeOfReservationReceived: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectNewButton.layer.cornerRadius = 15
        
        switch (typeOfReservationReceived!) {
        case 0:
            tableView.contentInset = UIEdgeInsetsMake(-70, 0, 0, 0)
            requestStatusBannerLabel.text = "Every caddie has 12 hours to respond to a reservation request. Your reservation will remain pending until it's confirmed or declined."
            selectNewButtonCell.isHidden = true
        case 1:
            tableView.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0)
            requestStatusBannerLabel.text = "Unfortunately, your requested caddie is unable to complete your reservation. Don't worry though, finding another caddie is easy."
            selectNewButtonCell.isHidden = false
        default:
            break
        }
    }
}

extension RequestedReservationDetailsViewController {
 
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (cell == cancelRequestCell) {
            let actionSheet = UIAlertController(title: "Cancel this reservation request?", message:  "\n This action will permanently delete this request and is subject to the Loop Golf Terms of Use.", preferredStyle: .actionSheet)
            actionSheet.view.tintColor = UIColor.black
            let closeAction = UIAlertAction(title: "Close", style: .cancel) { (action) in
            }
            actionSheet.addAction(closeAction)
            
            let cancelRequestAction = UIAlertAction(title: "Cancel this request", style: .destructive) { (action) in
            }
            actionSheet.addAction(cancelRequestAction)
            
            self.present(actionSheet, animated: true) {
                actionSheet.view.tintColor = UIColor.black
            }
        }
    }
}
