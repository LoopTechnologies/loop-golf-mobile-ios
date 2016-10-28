//
//  CaddiesContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class CaddiesContainerViewController: UITableViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var caddieNames: [String] = ["Kyle Reed", "Freddie Dunn"]
    var caddieHistory = ["August 2016","September 2016"]
    var roundsTogether = [3, 1]
    // --------------------------------------------------------------------------------//
    
    // Send data via segue.
    let segueSender = 1
    var profileNameForSegue = String()
    var profileSecondaryInfoForSegue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tableView.contentInset = UIEdgeInsetsMake(-34, 0, -34, 0)
        
    }
}

extension CaddiesContainerViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (caddieNames.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "You haven't golfed with any Loop caddies. Caddie connections are added after completing rounds of golf."
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConnectionsTableViewCell
        
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
        cell.nameLabel.text = caddieNames[(indexPath as NSIndexPath).row] as? String
        cell.secondaryLabel.text = "\(roundsTogether[(indexPath as NSIndexPath).row]) rounds together"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ConnectionsTableViewCell
        
        cell.cellBackgroundView.layer.cornerRadius = 8
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        profileNameForSegue = caddieNames[(indexPath as NSIndexPath).row]
        profileSecondaryInfoForSegue = caddieHistory[(indexPath as NSIndexPath).row]
        
        performSegue(withIdentifier: "toCaddieProfileSegue", sender: self)
        
        UIView.animate(withDuration: 0.1, delay: 0.5, options: .curveLinear, animations: {
            cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
            }, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toCaddieProfileSegue") {

            let destinationVC = segue.destination as! ConnectionPopoverViewController
            destinationVC.senderReceived = segueSender
            destinationVC.profileNameReceived = profileNameForSegue
            destinationVC.profileSecondaryInfoReceived = profileSecondaryInfoForSegue
        }
    }
}
