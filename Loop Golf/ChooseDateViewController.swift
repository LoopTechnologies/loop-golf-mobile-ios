//
//  ChooseDateViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/4/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ChooseDateViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseHoursLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var firstCircle: UIView!
    @IBOutlet weak var secondCircle: UIView!
    @IBOutlet weak var thirdCircle: UIView!
    
    var oneDayAheadOfCurrentDate = NSDate()
    var threeMonthsAheadOfCurrentDate = NSDate()
    
    
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
        backgroundImage.image = UIImage(named: "GolfCourseImage")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        backgroundView.layer.cornerRadius = 8
        
        calculateOneDayAhead()
        calculateThreeMonthsAhead()
        datePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")
        datePicker.subviews[0].subviews[1].hidden = true
        datePicker.minimumDate = oneDayAheadOfCurrentDate
        datePicker.maximumDate = threeMonthsAheadOfCurrentDate
        
        continueButton.layer.cornerRadius = 8
        
        progressBarView.layer.shadowColor = UIColor.blackColor().CGColor
        progressBarView.layer.shadowOpacity = 0.5
        progressBarView.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        firstCircle.layer.borderWidth = 2
        firstCircle.layer.borderColor = UIColor.blackColor().CGColor
        firstCircle.layer.cornerRadius = 15
        
        secondCircle.layer.borderWidth = 2
        secondCircle.layer.borderColor = UIColor.blackColor().CGColor
        secondCircle.layer.cornerRadius = 15
        
        thirdCircle.layer.borderWidth = 1
        thirdCircle.layer.borderColor = UIColor.lightGrayColor().CGColor
        thirdCircle.layer.cornerRadius = 15
        
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
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    
}
