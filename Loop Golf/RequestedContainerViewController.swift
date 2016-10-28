//
//  RequestedContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class RequestedContainerViewController: UITableViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var caddieNames: [String] = ["Mark Thompson", "Tom Donald"]
    var courseNames = ["Hearthstone Country Club", "Cypresswood Golf Club"]
    var courseLocations = ["Cypress, Texas", "Spring, Texas"]
    var dates = ["November 5, 2016", "November 20, 2016"]
    var times = ["12:05 PM", "3:20 PM"]
    var status = ["p", "d"]
    // --------------------------------------------------------------------------------//
    
    // Send data via segue.
    var segueSender = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
    }
}

extension RequestedContainerViewController {
    
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
            noDataLabel.text = "You don't have any requested reservations."
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
        
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
        cell.caddieNameLabel.text = caddieNames[(indexPath as NSIndexPath).row] as? String
        cell.courseNameLabel.text = courseNames[(indexPath as NSIndexPath).row] as? String
        cell.courseLocationLabel.text = courseLocations[(indexPath as NSIndexPath).row] as? String
        cell.reservationDateLabel.text = "\(dates[(indexPath as NSIndexPath).row]) at \(times[(indexPath as NSIndexPath).row])" as? String
        cell.statusLabel.layer.borderWidth = 1
        cell.statusLabel.layer.cornerRadius = 8
        
        if (status[(indexPath as NSIndexPath).row] == "p") {
            // Pending request.
            cell.statusLabel.text = "PENDING"
            cell.statusLabel.textColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
            cell.statusLabel.layer.borderColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0).cgColor
        } else if (status[(indexPath as NSIndexPath).row] == "d") {
            // Declined request.
            cell.statusLabel.text = "DECLINED"
            cell.statusLabel.textColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
            cell.statusLabel.layer.borderColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
        }

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ReservationsTableViewCell
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        if (status[(indexPath as NSIndexPath).row] == "p") {
            segueSender = 0
        } else if (status[(indexPath as NSIndexPath).row] == "d") {
            segueSender = 1
        }
        
        performSegue(withIdentifier: "toRequestSegue", sender: self)
        
        UIView.animate(withDuration: 0.1, delay: 0.5, options: .curveLinear, animations: {
            cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
            }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toRequestSegue") {
            
            let destinationVC = segue.destination as! ReservationPopoverViewController
            destinationVC.senderReceived = segueSender
        }
    }
}
