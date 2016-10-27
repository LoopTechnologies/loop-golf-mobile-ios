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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        switch (otherGolfersReceived!.count) {
        case 0:
            addGolfersLabel.text = "You can include up to three other golfers for this reservation."
            golfer1NameLabel.isHidden = true
            golfer1RemoveButton.isHidden = true
            golfer2NameLabel.isHidden = true
            golfer2RemoveButton.isHidden = true
            golfer3NameLabel.isHidden = true
            golfer3RemoveButton.isHidden = true
        case 1:
            addGolfersLabel.text = "You can include up to two other golfers for this reservation."
            addGolfer1Button.isHidden = true
            golfer1NameLabel.text = otherGolfersReceived![0]
            golfer2NameLabel.isHidden = true
            golfer2RemoveButton.isHidden = true
            golfer3NameLabel.isHidden = true
            golfer3RemoveButton.isHidden = true
        case 2:
            addGolfersLabel.text = "You can include up to one other golfer for this reservation."
            addGolfer1Button.isHidden = true
            golfer1NameLabel.text = otherGolfersReceived![0]
            addGolfer2Button.isHidden = true
            golfer2NameLabel.text = otherGolfersReceived![1]
            golfer3NameLabel.isHidden = true
            golfer3RemoveButton.isHidden = true
        case 3:
            addGolfersLabel.text = "You can't include any other golfers for this reservation."
            addGolfer1Button.isHidden = true
            golfer1NameLabel.text = otherGolfersReceived![0]
            addGolfer2Button.isHidden = true
            golfer2NameLabel.text = otherGolfersReceived![1]
            addGolfer3Button.isHidden = true
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    @IBAction func addGolfer1ButtonPressed(_ sender: AnyObject) {
        if (otherGolfersReceived!.count == 0) {
            performSegue(withIdentifier: "toAddGolferForReservationSegue", sender: self)
        }
    }
    
    @IBAction func addGolfer2ButtonPressed(_ sender: AnyObject) {
        if (otherGolfersReceived!.count == 1) {
            performSegue(withIdentifier: "toAddGolferForReservationSegue", sender: self)
        } else {
            let alertController = UIAlertController(title: "", message:  "Please add a golfer to the first slot before adding one here.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        }
    }
    
    @IBAction func addGolfer3ButtonPressed(_ sender: AnyObject) {
        if (otherGolfersReceived!.count == 2) {
            performSegue(withIdentifier: "toAddGolferForReservationSegue", sender: self)
        } else {
            let alertController = UIAlertController(title: "", message:  "Please add golfers to the first and second slots before adding one here.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (cell == cancelReservationCell) {
            let actionSheet = UIAlertController(title: "Cancel this confirmed reservation?", message:  "\n This action will permanently delete this reservation and is subject to the Loop Golf Terms of Use. Remember, if you're within 24 hours of your Loop round you will forfeit the 10% reservation fee that you've already been charged.", preferredStyle: .actionSheet)
            actionSheet.view.tintColor = UIColor.black
            let closeAction = UIAlertAction(title: "Close", style: .cancel) { (action) in
            }
            actionSheet.addAction(closeAction)
            
            let cancelRequestAction = UIAlertAction(title: "Cancel this reservation", style: .destructive) { (action) in
            }
            actionSheet.addAction(cancelRequestAction)
            
            self.present(actionSheet, animated: true) {
                actionSheet.view.tintColor = UIColor.black
            }
        }
    }
}
