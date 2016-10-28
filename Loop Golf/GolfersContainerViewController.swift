//
//  GolfersContainerViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class GolfersContainerViewController: UITableViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var golferNames: [String] = ["Larry David", "Jackie Chan"]
    var userNames = ["larry-david", "jack-chan-2"]
    // --------------------------------------------------------------------------------//
    
    // Send data via segue.
    let segueSender = 2
    var profileNameForSegue = String()
    var profileSecondaryInfoForSegue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
        
    }
}

extension GolfersContainerViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (golferNames.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "You don't have any golfer connections to show. Connect with your friends on Loop to start golfing together."
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
        return golferNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConnectionsTableViewCell
        
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
        cell.nameLabel.text = golferNames[(indexPath as NSIndexPath).row] as? String
        cell.secondaryLabel.text = "@\(userNames[(indexPath as NSIndexPath).row])"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ConnectionsTableViewCell
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        profileNameForSegue = golferNames[(indexPath as NSIndexPath).row]
        profileSecondaryInfoForSegue = userNames[(indexPath as NSIndexPath).row]
        
        performSegue(withIdentifier: "toGolferProfileSegue", sender: self)
        
        UIView.animate(withDuration: 0.1, delay: 0.5, options: .curveLinear, animations: {
            cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
            }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toGolferProfileSegue") {
            
            let destinationVC = segue.destination as! ConnectionPopoverViewController
            destinationVC.senderReceived = segueSender
            destinationVC.profileNameReceived = profileNameForSegue
            destinationVC.profileSecondaryInfoReceived = profileSecondaryInfoForSegue

        }
    }

}
