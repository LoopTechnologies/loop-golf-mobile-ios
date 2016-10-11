//
//  ConfirmRequestContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/7/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ConfirmRequestContainerViewController: UITableViewController {
    
    @IBOutlet weak var caddieProfileImage: UIImageView!
    @IBOutlet weak var caddieNameLabel: UILabel!
    @IBOutlet weak var acceptanceRateLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseLocationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var reservationPriceLabel: UILabel!
    
    let currencyFormatter = NSNumberFormatter()
    var reservationFee = Float()
    
    // Receive data from parent VC via segue.
    var courseNameReceived: String?
    var courseLocationReceived: String?
    var coursePriceReceived: Int?
    var dateTimeStringReceived: String?
    var fullStyleDateReceived: String?
    var timeStringReceived: String?
    var caddieNameReceived: String?
    var acceptanceRateReceived: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(7, 0, 7, 0)
        
        reservationFee = Float(coursePriceReceived!)/10
        
        currencyFormatter.numberStyle = .CurrencyStyle
        //Swift3: currencyFormatter.numberStyle = .currency
        //Swift3: currencyFormatter.string(from: reservationFee)
        
        
        caddieNameLabel.text = caddieNameReceived!
        acceptanceRateLabel.text = "\(acceptanceRateReceived!)% of requests accepted"
        courseNameLabel.text = courseNameReceived!
        courseLocationLabel.text = courseLocationReceived!
        dateLabel.text = fullStyleDateReceived!
        timeLabel.text = timeStringReceived!
        //TO DO: set payment method label
        feeLabel.text = "\((currencyFormatter.stringFromNumber(reservationFee))!)"
        reservationPriceLabel.text = "(10% of \((currencyFormatter.stringFromNumber(coursePriceReceived!))!))"
    }
}

extension ConfirmRequestContainerViewController {
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
}
