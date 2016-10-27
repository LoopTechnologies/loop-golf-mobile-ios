//
//  ChooseCaddieViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/5/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ChooseCaddieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var caddieNames = ["Jerry Marshall", "Tyler Dalton", "Brandon Smith", "Reed Winters"]
    var acceptanceRates = [85, 98, 90, 92]
    
    var sunAvailability = [true, false, true, false]
    var monAvailability = [true, true, false, true]
    var tueAvailability = [true, true, false, false]
    var wedAvailability = [true, true, false, true]
    var thuAvailability = [true, true, false, false]
    var friAvailability = [true, true, true, false]
    var satAvailability = [true, false, false, true]

    
    var golfKnowledge = [4.5, 4.2, 4.9, 3.8]
    var greenReading = [4.7, 4.4, 5.0, 4.2]
    var customerSatisfaction = [4.3, 4.6, 4.8, 4.1]
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarShadowView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseLocationLabel: UILabel!
    @IBOutlet weak var resDateTimeLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var firstCircle: UIView!
    @IBOutlet weak var secondCircle: UIView!
    @IBOutlet weak var thirdCircle: UIView!
    
    let timeFormatter12Hr = DateFormatter()
    var timeNSDate = Date()
    let dateFormatter = DateFormatter()
    var dateNSDate = Date()
    
    // Receive data via segue.
    var courseIDReceived: String?
    var courseNameReceivedAgain: String?
    var courseLocationReceivedAgain: String?
    var coursePriceReceivedAgain: Int?
    var selectedDateTimeStringReceived: String?
    var selectedFullStyleDateReceived: String?
    var selected12HrTimeStringReceived: String?
    
    // Send data via segue.
    var courseNameForSegue = String()
    var courseLocationForSegue = String()
    var coursePriceForSegue = Int()
    var selectedDateTimeStringForSegue = String()
    var selectedFullStyleDateForSegue = String()
    var selected12HrTimeStringForSegue = String()
    var caddieNameForSegue = String()
    var acceptanceRateForSegue = Int()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0)
        
        navigationItem.title = "Nearby Caddies"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "GolfCourseImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        navBarShadowView.layer.shadowColor = UIColor.black.cgColor
        navBarShadowView.layer.shadowOpacity = 0.5
        navBarShadowView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        topBarView.layer.shadowColor = UIColor.black.cgColor
        topBarView.layer.shadowOpacity = 0.5
        topBarView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        firstCircle.layer.borderWidth = 2
        firstCircle.layer.borderColor = UIColor.black.cgColor
        firstCircle.layer.cornerRadius = 15
        
        secondCircle.layer.borderWidth = 2
        secondCircle.layer.borderColor = UIColor.black.cgColor
        secondCircle.layer.cornerRadius = 15
        
        thirdCircle.layer.borderWidth = 2
        thirdCircle.layer.borderColor = UIColor.black.cgColor
        thirdCircle.layer.cornerRadius = 15

        
        courseNameLabel.text = courseNameReceivedAgain!
        
        courseLocationLabel.text = courseLocationReceivedAgain!
        
        resDateTimeLabel.text = "\(selectedFullStyleDateReceived!) at \(selected12HrTimeStringReceived!)"
    }
}

extension ChooseCaddieViewController {
    
    @objc(tableView:heightForRowAtIndexPath:)
    func tableView (_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    @objc(numberOfSectionsInTableView:)
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if (caddieNames.count > 0) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "Unfortunately no caddies appear to be available for your selected course, date, and time."
            noDataLabel.font = UIFont(name: "AvenirNext-Regular", size: 17)
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = NSTextAlignment.center
            noDataLabel.numberOfLines = 0
            noDataLabel.lineBreakMode = .byWordWrapping
            tableView.backgroundView = noDataLabel
            tableView.backgroundColor = UIColor.clear
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return caddieNames.count
    }
    
    
    @objc(tableView:cellForRowAtIndexPath:)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CaddieTableViewCell
        
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        cell.profileImageView.image = UIImage(named: "DefaultProfileImage")
        cell.profileImageView.layer.cornerRadius = 40
        
        cell.nameLabel.text = caddieNames[(indexPath as NSIndexPath).row]
        cell.acceptanceRateLabel.text = "\(acceptanceRates[(indexPath as NSIndexPath).row])% of requests accepted"
        
        
        if (sunAvailability[(indexPath as NSIndexPath).row] == true) {
            cell.sunAvailabilityLabel.textColor = UIColor.white
            cell.sunAvailabilityLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        if (monAvailability[(indexPath as NSIndexPath).row] == true) {
            cell.monAvailabilityLabel.textColor = UIColor.white
            cell.monAvailabilityLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        if (tueAvailability[(indexPath as NSIndexPath).row] == true) {
            cell.tueAvailabilityLabel.textColor = UIColor.white
            cell.tueAvailabilityLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        if (wedAvailability[(indexPath as NSIndexPath).row] == true) {
            cell.wedAvailabilityLabel.textColor = UIColor.white
            cell.wedAvailabilityLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        if (thuAvailability[(indexPath as NSIndexPath).row] == true) {
            cell.thuAvailabilityLabel.textColor = UIColor.white
            cell.thuAvailabilityLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        if (friAvailability[(indexPath as NSIndexPath).row] == true) {
            cell.friAvailabilityLabel.textColor = UIColor.white
            cell.friAvailabilityLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        if (satAvailability[(indexPath as NSIndexPath).row] == true) {
            cell.satAvailabilityLabel.textColor = UIColor.white
            cell.satAvailabilityLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        cell.golfKnowledgeRatingLabel.text = "\(golfKnowledge[(indexPath as NSIndexPath).row])"
        cell.greenReadingRatingLabel.text = "\(greenReading[(indexPath as NSIndexPath).row])"
        cell.customerSatisfactionRatingLabel.text = "\(customerSatisfaction[(indexPath as NSIndexPath).row])"
        
        return cell
    }
    
    @objc(tableView:didSelectRowAtIndexPath:)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CaddieTableViewCell
        cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.8).cgColor
        
        caddieNameForSegue = caddieNames[(indexPath as NSIndexPath).row]
        acceptanceRateForSegue = acceptanceRates[(indexPath as NSIndexPath).row]
        
        performSegue(withIdentifier: "toConfirmReservationSegue", sender: self)
        
        UIView.animate(withDuration: 0.1, delay: 0.5, options: .curveLinear, animations: {
            cell.cellBackgroundView.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
        }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toConfirmReservationSegue") {
            let destinationVC = segue.destination as! ConfirmRequestViewController

            courseNameForSegue = courseNameReceivedAgain!
            courseLocationForSegue = courseLocationReceivedAgain!
            coursePriceForSegue = coursePriceReceivedAgain!
            selectedDateTimeStringForSegue = selectedDateTimeStringReceived!
            selectedFullStyleDateForSegue = selectedFullStyleDateReceived!
            selected12HrTimeStringForSegue = selected12HrTimeStringReceived!
            
            destinationVC.courseNameReceivedTwice = courseNameForSegue
            destinationVC.courseLocationReceivedTwice = courseLocationForSegue
            destinationVC.coursePriceReceivedTwice = coursePriceForSegue
            destinationVC.selectedDateTimeStringReceivedAgain = selectedDateTimeStringForSegue
            destinationVC.selectedFullStyleDateReceivedAgain = selectedFullStyleDateForSegue
            destinationVC.selected12HrTimeStringReceivedAgain = selected12HrTimeStringForSegue
            destinationVC.caddieNameReceived = caddieNameForSegue
            destinationVC.acceptanceRateReceived = acceptanceRateForSegue
        }
    }
}
