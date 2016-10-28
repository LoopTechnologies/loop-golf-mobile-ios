//
//  CaddieConnectionDetailsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/17/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class CaddieConnectionDetailsViewController: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var reserveAgainButton: UIButton!
    @IBOutlet weak var lifetimeRoundsLabel: UILabel!
    @IBOutlet weak var mostRecentLabel: UILabel!
    @IBOutlet weak var golfKnowledgeCellPrimaryLabel: UILabel!
    @IBOutlet weak var golfKnowledgeCellSecondaryLabel: UILabel!
    @IBOutlet weak var golfKnowledgeSegmentedControl: RatingScaleSegmentedControl!
    @IBOutlet weak var editRatingsButton: UIButton!
    @IBOutlet weak var greenReadingRatingCell: UITableViewCell!
    @IBOutlet weak var customerSatisfactionRatingCell: UITableViewCell!
    @IBOutlet weak var saveChangesCell: UITableViewCell!
    @IBOutlet weak var saveChangesButton: UIButton!
    
    // Receive from parent VC via segue.
    var profileNameReceived: String?
    var profileSecondaryInfoReceived: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(-19, 0, -331, 0)
        profileImageView.layer.cornerRadius = 8
        reserveAgainButton.layer.cornerRadius = 8
        editRatingsButton.layer.cornerRadius = 8
        saveChangesButton.layer.cornerRadius = 8
        
        editRatingsButton.isHidden = false
        golfKnowledgeCellPrimaryLabel.text = "Have you rated this caddie?"
        golfKnowledgeCellSecondaryLabel.text = "Your ratings make Loop Golf a better place by helping others pick their perfect caddie."
        golfKnowledgeSegmentedControl.isHidden = true
        greenReadingRatingCell.isHidden = true
        customerSatisfactionRatingCell.isHidden = true
        saveChangesCell.isHidden = true
        
        nameLabel.text = profileNameReceived!
        secondaryLabel.text = "Member since \(profileSecondaryInfoReceived!)"
    }
}

extension CaddieConnectionDetailsViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @IBAction func editRatingsButtonPressed(_ sender: AnyObject) {
        tableView.contentInset = UIEdgeInsetsMake(-19, 0, 1, 0)
        profileImageView.layer.cornerRadius = 40
        editRatingsButton.isHidden = true
        golfKnowledgeCellPrimaryLabel.text = "Golf Knowledge"
        golfKnowledgeCellPrimaryLabel.textAlignment = .left
        golfKnowledgeCellSecondaryLabel.text = "How much does this caddie know about golf and a caddie's role?"
        golfKnowledgeCellSecondaryLabel.textAlignment = .left
        golfKnowledgeSegmentedControl.isHidden = false
        greenReadingRatingCell.isHidden = false
        customerSatisfactionRatingCell.isHidden = false
        saveChangesCell.isHidden = false
    }
    
}
