//
//  DetailsContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/4/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class DetailsContainerViewController: UITableViewController {
    
    @IBOutlet weak var membershipAndLocationCell: UITableViewCell!
    @IBOutlet weak var overviewCell: UITableViewCell!
    @IBOutlet weak var facilitiesCell: UITableViewCell!
    @IBOutlet weak var amenitiesCell: UITableViewCell!
    @IBOutlet weak var offersCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.contentInset = UIEdgeInsetsMake(7, 0, 7, 0)
        
        membershipAndLocationCell.contentView.layer.cornerRadius = 8
        membershipAndLocationCell.contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        
        overviewCell.contentView.layer.cornerRadius = 8
        overviewCell.contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        
        facilitiesCell.contentView.layer.cornerRadius = 8
        facilitiesCell.contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)

        amenitiesCell.contentView.layer.cornerRadius = 8
        amenitiesCell.contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)

        offersCell.contentView.layer.cornerRadius = 8
        offersCell.contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)

    }
}

extension DetailsContainerViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}
