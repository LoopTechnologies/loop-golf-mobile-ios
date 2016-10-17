//
//  CaddieConnectionDetailsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/17/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class CaddieConnectionDetailsViewController: UITableViewController {
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, -340, 0)
        reserveAgainButton.layer.cornerRadius = 15
        editRatingsButton.layer.cornerRadius = 15
        saveChangesButton.layer.cornerRadius = 15
        
        editRatingsButton.hidden = false
        golfKnowledgeCellPrimaryLabel.text = "Have you rated this caddie?"
        golfKnowledgeCellSecondaryLabel.text = "Your ratings make Loop Golf a better place by helping others pick their perfect caddie."
        golfKnowledgeSegmentedControl.hidden = true
        greenReadingRatingCell.hidden = true
        customerSatisfactionRatingCell.hidden = true
        saveChangesCell.hidden = true
    }
}

extension CaddieConnectionDetailsViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @IBAction func editRatingsButtonPressed(sender: AnyObject) {
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, 10, 0)
        editRatingsButton.hidden = true
        golfKnowledgeCellPrimaryLabel.text = "Golf Knowledge"
        golfKnowledgeCellPrimaryLabel.textAlignment = .Left
        golfKnowledgeCellSecondaryLabel.text = "How much does this caddie know about golf and a caddie's role?"
        golfKnowledgeCellSecondaryLabel.textAlignment = .Left
        golfKnowledgeSegmentedControl.hidden = false
        greenReadingRatingCell.hidden = false
        customerSatisfactionRatingCell.hidden = false
        saveChangesCell.hidden = false
    }
    
}
