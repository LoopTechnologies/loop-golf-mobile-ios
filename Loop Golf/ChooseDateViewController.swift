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
    
    var oneDayAheadOfCurrentDate = NSDate()
    var threeMonthsAheadOfCurrentDate = NSDate()
    
    let dateTimeFormatter = NSDateFormatter()
    let timeFormatter12Hr = NSDateFormatter()
    let dateFormatterFullStyle = NSDateFormatter()
    let timeFormatter24Hr = NSDateFormatter()
    var selected24HrTimeNSDate = NSDate()
    var validOpen24HrTimeNSDate = NSDate()
    var validClose24HrTimeNSDate = NSDate()

    // Send data via segue.
    var courseNameForSegue = String()
    var courseLocationForSegue = String()
    var selectedDateTimeStringForSegue = String()
    var selected12HrTimeStringForSegue = String()
    var selectedFullStyleDateForSegue = String()
    
    // Receive data via segue.
    var courseIDReceived: String?
    var courseNameReceived: String?
    var courseLocationReceived: String?
    var courseOpenHrsReceived: String?
    var courseCloseHrsReceived: String?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Date and Time"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.blackColor()]
        navigationController?.navigationBar.tintColor = UIColor.blackColor()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        backgroundView.layer.cornerRadius = 8
        
        calculateOneDayAhead()
        calculateThreeMonthsAhead()
        datePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        datePicker.subviews[0].subviews[1].hidden = true
        datePicker.subviews[0].subviews[2].hidden = true
        datePicker.minimumDate = oneDayAheadOfCurrentDate
        datePicker.maximumDate = threeMonthsAheadOfCurrentDate
        
        continueButton.layer.cornerRadius = 8
        continueButton.layer.borderWidth = 1
        continueButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        topBarView.layer.shadowColor = UIColor.blackColor().CGColor
        topBarView.layer.shadowOpacity = 0.5
        topBarView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        firstCircle.layer.borderWidth = 2
        firstCircle.layer.borderColor = UIColor.blackColor().CGColor
        firstCircle.layer.cornerRadius = 15
        
        secondCircle.layer.borderWidth = 2
        secondCircle.layer.borderColor = UIColor.blackColor().CGColor
        secondCircle.layer.cornerRadius = 15
        
        thirdCircle.layer.borderWidth = 1
        thirdCircle.layer.borderColor = UIColor.lightGrayColor().CGColor
        thirdCircle.layer.cornerRadius = 15
        
        dateTimeFormatter.dateFormat = "yyyy-MM-dd H:mm"
        
        timeFormatter12Hr.dateFormat = "h:mm a"
        
        dateFormatterFullStyle.dateFormat = "yyyy-MM-dd"
        dateFormatterFullStyle.dateStyle = .FullStyle
        
        timeFormatter24Hr.dateFormat = "HH:mm"
        
        validOpen24HrTimeNSDate = timeFormatter24Hr.dateFromString(opHoursOpen)!
        validClose24HrTimeNSDate = timeFormatter24Hr.dateFromString(opHoursClose)!
        
        if (courseNameReceived != "") {
            courseNameLabel.text = courseNameReceived!
        }
        
        if (courseLocationReceived != "") {
            courseLocationLabel.text = courseLocationReceived!
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension ChooseDateViewController {
    
    func calculateOneDayAhead() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        dateComponents.day = +1
        oneDayAheadOfCurrentDate = calendar.dateByAddingComponents(dateComponents, toDate: NSDate(), options: [])!
        return oneDayAheadOfCurrentDate
    }
    
    func calculateThreeMonthsAhead() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        dateComponents.month = +3
        threeMonthsAheadOfCurrentDate = calendar.dateByAddingComponents(dateComponents, toDate: NSDate(), options: [])!
        return threeMonthsAheadOfCurrentDate
    }
    
    @IBAction func continueButtonPressed(sender: AnyObject) {
        
        // To store in DB and/or pass via segue: full date-time string 'yyyy-MM-dd HH:mm'.
        selectedDateTimeStringForSegue = dateTimeFormatter.stringFromDate(datePicker.date)
        
        // To pass via segue to display: 12 hour time string 'h:mm a'.
        selected12HrTimeStringForSegue = timeFormatter12Hr.stringFromDate(datePicker.date)
        
        // To pass via segue to display: .FullStyle date.
        selectedFullStyleDateForSegue = dateFormatterFullStyle.stringFromDate(datePicker.date)
        
        // To evaluate chosen time versus operating hours: 24 hour time NSDate 'HH:mm'.
        let selected24HrTimeString = timeFormatter24Hr.stringFromDate(datePicker.date)
        selected24HrTimeNSDate = timeFormatter24Hr.dateFromString(selected24HrTimeString)!

        evaluateSelectedTime(selected24HrTimeNSDate, operatingHoursOpen: validOpen24HrTimeNSDate, operatingHoursClose: validClose24HrTimeNSDate)
        
    }
    
    func evaluateSelectedTime(selected24HrTimeNSDate: NSDate, operatingHoursOpen: NSDate, operatingHoursClose: NSDate) -> Bool {
        
        if (selected24HrTimeNSDate.compare(validOpen24HrTimeNSDate) == NSComparisonResult.OrderedDescending) {
            if (selected24HrTimeNSDate.compare(validClose24HrTimeNSDate) == NSComparisonResult.OrderedAscending) {
                performSegueWithIdentifier("toChooseCaddieSegue", sender: self)
                return true
            }
        }
        
        let alertController = UIAlertController(title: "Please choose a valid time.", message:  "\n The start time for your caddie reservation must be within the operating hours of your selected course.", preferredStyle: .Alert)
        alertController.view.tintColor = UIColor.blackColor()
        let doneAction = UIAlertAction(title: "Try Again", style: .Cancel) { (action) in
        }
        alertController.addAction(doneAction)
        self.presentViewController(alertController, animated: true) {
            alertController.view.tintColor = UIColor.blackColor()
        }
        return false
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toChooseCaddieSegue") {
            let destinationVC = segue.destinationViewController as! ChooseCaddieViewController
            courseNameForSegue = courseNameReceived!
            courseLocationForSegue = courseLocationReceived!
            
            destinationVC.courseNameReceivedAgain = courseNameForSegue
            destinationVC.courseLocationReceivedAgain = courseLocationForSegue
            destinationVC.selectedDateTimeStringReceived = selectedDateTimeStringForSegue
            destinationVC.selectedFullStyleDateReceived = selectedFullStyleDateForSegue
            destinationVC.selected12HrTimeStringReceived = selected12HrTimeStringForSegue
        }
    }
    
    
    
}
