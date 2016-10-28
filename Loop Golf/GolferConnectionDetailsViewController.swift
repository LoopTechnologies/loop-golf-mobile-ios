//
//  GolferConnectionDetailsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/17/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class GolferConnectionDetailsViewController: UITableViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var addToReservationButton: UIButton!
    @IBOutlet weak var lifetimeRoundsLabel: UILabel!
    @IBOutlet weak var mostRecentLabel: UILabel!
    
    // Receive from parent VC via segue.
    var profileNameReceived: String?
    var profileSecondaryInfoReceived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(-19, 0, 1, 0)
        profileImageView.layer.cornerRadius = 8
        addToReservationButton.layer.cornerRadius = 8
        
        nameLabel.text = profileNameReceived!
        secondaryLabel.text = "@\(profileSecondaryInfoReceived!)"
    }
}

extension GolferConnectionDetailsViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
