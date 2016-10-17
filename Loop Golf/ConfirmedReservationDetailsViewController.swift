//
//  ConfirmedReservationDetailsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/14/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ConfirmedReservationDetailsViewController: UITableViewController {
    
    @IBOutlet weak var reservingGolferCell: UITableViewCell!
    @IBOutlet weak var reservingGolferNameLabel: UILabel!
    @IBOutlet weak var addGolfersLabel: UILabel!
    @IBOutlet weak var golfer1Cell: UITableViewCell!
    @IBOutlet weak var addGolfer1Button: UIButton!
    @IBOutlet weak var golfer1NameLabel: UILabel!
    @IBOutlet weak var golfer1RemoveButton: UIButton!
    @IBOutlet weak var golfer2Cell: UITableViewCell!
    @IBOutlet weak var addGolfer2Button: UIButton!
    @IBOutlet weak var golfer2NameLabel: UILabel!
    @IBOutlet weak var golfer2RemoveButton: UIButton!
    @IBOutlet weak var golfer3Cell: UITableViewCell!
    @IBOutlet weak var addGolfer3Button: UIButton!
    @IBOutlet weak var golfer3NameLabel: UILabel!
    @IBOutlet weak var golfer3RemoveButton: UIButton!
    
    
    // Receive data from parent VC via segue.
    var typeOfReservationReceived: Int?
    var otherGolfersReceived: [String]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        switch (otherGolfersReceived!.count) {
        case 0:
            addGolfersLabel.text = "You can include up to three other golfers for this reservation."
            golfer1NameLabel.hidden = true
            golfer1RemoveButton.hidden = true
            golfer2NameLabel.hidden = true
            golfer2RemoveButton.hidden = true
            golfer3NameLabel.hidden = true
            golfer3RemoveButton.hidden = true
        case 1:
            addGolfersLabel.text = "You can include up to two other golfers for this reservation."
            addGolfer1Button.hidden = true
            golfer1NameLabel.text = otherGolfersReceived![0]
            golfer2NameLabel.hidden = true
            golfer2RemoveButton.hidden = true
            golfer3NameLabel.hidden = true
            golfer3RemoveButton.hidden = true
        case 2:
            addGolfersLabel.text = "You can include up to one other golfer for this reservation."
            addGolfer1Button.hidden = true
            golfer1NameLabel.text = otherGolfersReceived![0]
            addGolfer2Button.hidden = true
            golfer2NameLabel.text = otherGolfersReceived![1]
            golfer3NameLabel.hidden = true
            golfer3RemoveButton.hidden = true
        case 3:
            addGolfersLabel.text = "You can't include any other golfers for this reservation."
            addGolfer1Button.hidden = true
            golfer1NameLabel.text = otherGolfersReceived![0]
            addGolfer2Button.hidden = true
            golfer2NameLabel.text = otherGolfersReceived![1]
            addGolfer3Button.hidden = true
            golfer3NameLabel.text = otherGolfersReceived![2]
        default:
            break
        }
        
        /*
        switch (typeOfReservationReceived!) {
        case 2:
            print("confirmed")
        default:
            break
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(-10, 0, 10, 0)
    }
}

extension ConfirmedReservationDetailsViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
