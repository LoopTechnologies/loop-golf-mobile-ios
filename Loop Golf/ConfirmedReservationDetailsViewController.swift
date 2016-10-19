//
//  ConfirmedReservationDetailsViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/14/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ConfirmedReservationDetailsViewController: UITableViewController {
    
    @IBOutlet weak var reservingGolferCell: UITableViewCell!
    @IBOutlet weak var reservingGolferNameLabel: UILabel!
    @IBOutlet weak var addGolfersLabel: UILabel!
    @IBOutlet weak var golfer1Cell: UITableViewCell!
    @IBOutlet weak var addGolfer1Button: UIButton!
    @IBOutlet weak var golfer1NameLabel: UILabel!
    @IBOutlet weak var golfer1RemoveButton: UIButton!
    @IBOutlet weak var golfer2Cell: UITableViewCell!
    @IBOutlet weak var addGolfer2Button: UIButton!
    @IBOutlet weak var golfer2NameLabel: UILabel!
    @IBOutlet weak var golfer2RemoveButton: UIButton!
    @IBOutlet weak var golfer3Cell: UITableViewCell!
    @IBOutlet weak var addGolfer3Button: UIButton!
    @IBOutlet weak var golfer3NameLabel: UILabel!
    @IBOutlet weak var golfer3RemoveButton: UIButton!
    @IBOutlet weak var cancelReservationCell: UITableViewCell!
    
    
    
    // Receive data from parent VC via segue.
    var typeOfReservationReceived: Int?
    var otherGolfersReceived: [String]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        switch (otherGolfersReceived!.count) {
        case 0:
            addGolfersLabel.text = "You can include up to three other golfers for this reservation."
            golfer1NameLabel.hidden = true
            golfer1RemoveButton.hidden = true
            golfer2NameLabel.hidden = true
            golfer2RemoveButton.hidden = true
            golfer3NameLabel.hidden = true
            golfer3RemoveButton.hidden = true
        case 1:
            addGolfersLabel.text = "You can include up to two other golfers for this reservation."
            addGolfer1Button.hidden = true
            golfer1NameLabel.text = otherGolfersReceived![0]
            golfer2NameLabel.hidden = true
            golfer2RemoveButton.hidden = true
            golfer3NameLabel.hidden = true
            golfer3RemoveButton.hidden = true
        case 2:
            addGolfersLabel.text = "You can include up to one other golfer for this reservation."
            addGolfer1Button.hidden = true
            golfer1NameLabel.text = otherGolfersReceived![0]
            addGolfer2Button.hidden = true
            golfer2NameLabel.text = otherGolfersReceived![1]
            golfer3NameLabel.hidden = true
            golfer3RemoveButton.hidden = true
        case 3:
            addGolfersLabel.text = "You can't include any other golfers for this reservation."
            addGolfer1Button.hidden = true
            golfer1NameLabel.text = otherGolfersReceived![0]
            addGolfer2Button.hidden = true
            golfer2NameLabel.text = otherGolfersReceived![1]
            addGolfer3Button.hidden = true
            golfer3NameLabel.text = otherGolfersReceived![2]
        default:
            break
        }
        
        /*
        switch (typeOfReservationReceived!) {
        case 2:
            print("confirmed")
        default:
            break
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(-9, 0, 1, 0)
    }
}

extension ConfirmedReservationDetailsViewController {
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @IBAction func addGolfer1ButtonPressed(sender: AnyObject) {
        if (otherGolfersReceived!.count == 0) {
            performSegueWithIdentifier("toAddGolferForReservationSegue", sender: self)
        }
    }
    
    @IBAction func addGolfer2ButtonPressed(sender: AnyObject) {
        if (otherGolfersReceived!.count == 1) {
            performSegueWithIdentifier("toAddGolferForReservationSegue", sender: self)
        } else {
            let alertController = UIAlertController(title: "", message:  "Please add a golfer to the first slot before adding one here.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor.blackColor()
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor.blackColor()
            }
        }
    }
    
    @IBAction func addGolfer3ButtonPressed(sender: AnyObject) {
        if (otherGolfersReceived!.count == 2) {
            performSegueWithIdentifier("toAddGolferForReservationSegue", sender: self)
        } else {
            let alertController = UIAlertController(title: "", message:  "Please add golfers to the first and second slots before adding one here.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor.blackColor()
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor.blackColor()
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (cell == cancelReservationCell) {
            let actionSheet = UIAlertController(title: "Cancel this confirmed reservation?", message:  "\n This action will permanently delete this reservation and is subject to the Loop Golf Terms of Use. Remember, if you're within 24 hours of your Loop round you will forfeit the 10% reservation fee that you've already been charged.", preferredStyle: .ActionSheet)
            actionSheet.view.tintColor = UIColor.blackColor()
            let closeAction = UIAlertAction(title: "Close", style: .Cancel) { (action) in
            }
            actionSheet.addAction(closeAction)
            
            let cancelRequestAction = UIAlertAction(title: "Cancel this reservation", style: .Destructive) { (action) in
            }
            actionSheet.addAction(cancelRequestAction)
            
            self.presentViewController(actionSheet, animated: true) {
                actionSheet.view.tintColor = UIColor.blackColor()
            }
        }
    }
}
