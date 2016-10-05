//
//  CalendarContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/4/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class CalendarContainerViewController: UITableViewController {
    
    @IBOutlet weak var monthOneCell: UITableViewCell!
    @IBOutlet weak var monthTwoCell: UITableViewCell!
    @IBOutlet weak var monthThreeCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.contentInset = UIEdgeInsetsMake(7, 0, 7, 0)
        
        monthOneCell.contentView.layer.cornerRadius = 8
        monthOneCell.contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        
        monthTwoCell.contentView.layer.cornerRadius = 8
        monthTwoCell.contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        
        monthThreeCell.contentView.layer.cornerRadius = 8
        monthThreeCell.contentView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
    }
}

extension CalendarContainerViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}