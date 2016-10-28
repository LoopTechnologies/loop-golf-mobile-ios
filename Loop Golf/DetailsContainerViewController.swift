//
//  DetailsContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/4/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class DetailsContainerViewController: UITableViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var membershipHistory = "Member since September 2016"
    var streetAddress = "1001 E Memorial Loop"
    var cityStateZip = "Houston, Texas 77007"
    var courseSummary = "Memorial Park Golf Course is known as one of the best municipal courses in the nation and is visited by more than 60,000 patrons each year. The course originally began as a 9-hole course with sand greens, built near the hospital at Camp Logan for use by convalescent soldiers (1912). In 1935, following the closing of the hospital, golf course architect John Bredemus redesigned the course."
    var facilities = "A practice range with 60 bays and turf hitting surfaces means that golfers can always find a place to warmup rain or shine."
    var amenities = "With a Beck's Prime on site, golfers can enjoy a burger and beer on the patio overlooking the first tee."
    var offers = "Mention that you are golfing with a Loop caddie and receive 50% off merchandise in the club house."

    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var membershipAndLocationCell: UITableViewCell!
    @IBOutlet weak var membershipHistoryLabel: UILabel!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityStateZipLabel: UILabel!
    @IBOutlet weak var overviewCell: UITableViewCell!
    @IBOutlet weak var courseSummaryLabel: UILabel!
    @IBOutlet weak var facilitiesCell: UITableViewCell!
    @IBOutlet weak var facilitiesHighlightLabel: UILabel!
    @IBOutlet weak var amenitiesCell: UITableViewCell!
    @IBOutlet weak var amenitiesHighlightLabel: UILabel!
    @IBOutlet weak var offersCell: UITableViewCell!
    @IBOutlet weak var offersLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.tableView.contentInset = UIEdgeInsetsMake(-5, 0, -5, 0)
        
        membershipAndLocationCell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        overviewCell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        facilitiesCell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        amenitiesCell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        offersCell.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        membershipHistoryLabel.text = membershipHistory
        streetAddressLabel.text = streetAddress
        cityStateZipLabel.text = cityStateZip
        courseSummaryLabel.text = courseSummary
        facilitiesHighlightLabel.text = facilities
        amenitiesHighlightLabel.text = amenities
        offersLabel.text = offers

    }
}

extension DetailsContainerViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}
