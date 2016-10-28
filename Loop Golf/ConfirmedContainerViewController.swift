//
//  ConfirmedContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ConfirmedContainerViewController: UITableViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var caddieNames: [String] = ["Jerry Marshall"]
    var courseNames = ["The Woodlands Country Club: Palmer Course"]
    var courseLocations = ["Spring, Texas"]
    var dates = ["November 25, 2016"]
    var times = ["3:25 PM"]
    
    // --------------------------------------------------------------------------------//
    
    // Send data via segue.
    let segueSender = 2 //MUST BE 2 or 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tableView.contentInset = UIEdgeInsetsMake(-34, 0, -34, 0)
    }
}

extension ConfirmedContainerViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (caddieNames.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "You don't have any confirmed reservations."
            noDataLabel.font = UIFont(name: "AvenirNext-Regular", size: 20)
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = NSTextAlignment.center
            noDataLabel.numberOfLines = 0
            noDataLabel.lineBreakMode = .byWordWrapping
            tableView.backgroundView = noDataLabel
            tableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        }
        return numOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caddieNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReservationsTableViewCell
        
        cell.cellBackgroundView.layer.cornerRadius = 8
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
        cell.caddieNameLabel.text = caddieNames[(indexPath as NSIndexPath).row] as? String
        cell.courseNameLabel.text = courseNames[(indexPath as NSIndexPath).row] as? String
        cell.courseLocationLabel.text = courseLocations[(indexPath as NSIndexPath).row] as? String
        cell.reservationDateLabel.text = "\(dates[(indexPath as NSIndexPath).row]) at \(times[(indexPath as NSIndexPath).row])" as? String
        cell.statusLabel.layer.borderWidth = 1
        cell.statusLabel.layer.cornerRadius = 8
        cell.statusLabel.layer.borderColor = UIColor(red: 0/255, green: 204/255, blue: 0/255, alpha: 1.0).cgColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ReservationsTableViewCell
        cell.layer.cornerRadius = 8
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        performSegue(withIdentifier: "toConfirmedSegue", sender: self)
        
        UIView.animate(withDuration: 0.1, delay: 0.5, options: .curveLinear, animations: {
            cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
            }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toConfirmedSegue") {
            
            let destinationVC = segue.destination as! ReservationPopoverViewController
            destinationVC.senderReceived = segueSender
        }
    }
    
}

