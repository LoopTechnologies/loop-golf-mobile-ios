//
//  ChooseDateViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/4/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var opHoursOpen = "7:05"
    var opHoursClose = "17:30"
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var navBarShadowView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseLocationLabel: UILabel!
    @IBOutlet weak var courseHoursLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var firstCircle: UIView!
    @IBOutlet weak var secondCircle: UIView!
    @IBOutlet weak var thirdCircle: UIView!
    
    var oneDayAheadOfCurrentDate = Date()
    var threeMonthsAheadOfCurrentDate = Date()
    
    let dateTimeFormatter = DateFormatter()
    let timeFormatter12Hr = DateFormatter()
    let dateFormatterFullStyle = DateFormatter()
    let timeFormatter24Hr = DateFormatter()
    var selected24HrTimeNSDate = Date()
    var validOpen24HrTimeNSDate = Date()
    var validClose24HrTimeNSDate = Date()

    // Receive data via segue.
    var courseIDReceived: String?
    var courseNameReceived: String?
    var courseLocationReceived: String?
    var coursePriceReceived: Int?
    var courseOpenHrsReceived: String?
    var courseCloseHrsReceived: String?
    
    // Send data via segue.
    var courseNameForSegue = String()
    var courseLocationForSegue = String()
    var coursePriceForSegue = Int()
    var selectedDateTimeStringForSegue = String()
    var selected12HrTimeStringForSegue = String()
    var selectedFullStyleDateForSegue = String()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Date and Time"
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
        
        continueButton.layer.cornerRadius = 8
        continueButton.layer.borderWidth = 1
        continueButton.layer.borderColor = UIColor.white.cgColor
        
        topBarView.layer.shadowColor = UIColor.black.cgColor
        topBarView.layer.shadowOpacity = 0.5
        topBarView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        firstCircle.layer.borderWidth = 2
        firstCircle.layer.borderColor = UIColor.black.cgColor
        firstCircle.layer.cornerRadius = 15
        
        secondCircle.layer.borderWidth = 2
        secondCircle.layer.borderColor = UIColor.black.cgColor
        secondCircle.layer.cornerRadius = 15
        
        thirdCircle.layer.borderWidth = 1
        thirdCircle.layer.borderColor = UIColor.lightGray.cgColor
        thirdCircle.layer.cornerRadius = 15
        
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        datePicker.subviews[0].subviews[1].isHidden = true
        datePicker.subviews[0].subviews[2].isHidden = true
        
        
        //datePicker.minimumDate = oneDayAheadOfCurrentDate
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        //datePicker.maximumDate = threeMonthsAheadOfCurrentDate
        datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 3, to: Date())
        
        dateTimeFormatter.dateFormat = "yyyy-MM-dd H:mm"
        
        timeFormatter12Hr.dateFormat = "h:mm a"
        
        dateFormatterFullStyle.dateFormat = "yyyy-MM-dd"
        dateFormatterFullStyle.dateStyle = .full
        
        timeFormatter24Hr.dateFormat = "HH:mm"
        
        validOpen24HrTimeNSDate = timeFormatter24Hr.date(from: opHoursOpen)!
        validClose24HrTimeNSDate = timeFormatter24Hr.date(from: opHoursClose)!
        
        if (courseNameReceived != "") {
            courseNameLabel.text = courseNameReceived!
        }
        
        if (courseLocationReceived != "") {
            courseLocationLabel.text = courseLocationReceived!
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension ChooseDateViewController {
    
    @IBAction func continueButtonPressed(_ sender: AnyObject) {
        
        // To store in DB and/or pass via segue: full date-time string 'yyyy-MM-dd HH:mm'.
        selectedDateTimeStringForSegue = dateTimeFormatter.string(from: datePicker.date)
        
        // To pass via segue to display: 12 hour time string 'h:mm a'.
        selected12HrTimeStringForSegue = timeFormatter12Hr.string(from: datePicker.date)
        
        // To pass via segue to display: .FullStyle date.
        selectedFullStyleDateForSegue = dateFormatterFullStyle.string(from: datePicker.date)
        
        // To evaluate chosen time versus operating hours: 24 hour time NSDate 'HH:mm'.
        let selected24HrTimeString = timeFormatter24Hr.string(from: datePicker.date)
        selected24HrTimeNSDate = timeFormatter24Hr.date(from: selected24HrTimeString)!

        evaluateSelectedTime(selected24HrTimeNSDate, operatingHoursOpen: validOpen24HrTimeNSDate, operatingHoursClose: validClose24HrTimeNSDate)
        
    }
    
    func evaluateSelectedTime(_ selected24HrTimeNSDate: Date, operatingHoursOpen: Date, operatingHoursClose: Date) -> Bool {
        
        if (selected24HrTimeNSDate.compare(validOpen24HrTimeNSDate) == ComparisonResult.orderedDescending) {
            if (selected24HrTimeNSDate.compare(validClose24HrTimeNSDate) == ComparisonResult.orderedAscending) {
                performSegue(withIdentifier: "toChooseCaddieSegue", sender: self)
                return true
            }
        }
        
        let alertController = UIAlertController(title: "Please choose a valid time.", message:  "\n The start time for your caddie reservation must be within the operating hours of your selected course.", preferredStyle: .alert)
        alertController.view.tintColor = UIColor.black
        let doneAction = UIAlertAction(title: "Try Again", style: .cancel) { (action) in
        }
        alertController.addAction(doneAction)
        self.present(alertController, animated: true) {
            alertController.view.tintColor = UIColor.black
        }
        return false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toChooseCaddieSegue") {
            let destinationVC = segue.destination as! ChooseCaddieViewController
            courseNameForSegue = courseNameReceived!
            courseLocationForSegue = courseLocationReceived!
            coursePriceForSegue = coursePriceReceived!
            
            destinationVC.courseNameReceivedAgain = courseNameForSegue
            destinationVC.courseLocationReceivedAgain = courseLocationForSegue
            destinationVC.coursePriceReceivedAgain = coursePriceForSegue
            destinationVC.selectedDateTimeStringReceived = selectedDateTimeStringForSegue
            destinationVC.selectedFullStyleDateReceived = selectedFullStyleDateForSegue
            destinationVC.selected12HrTimeStringReceived = selected12HrTimeStringForSegue
        }
    }
    
    
    
}
