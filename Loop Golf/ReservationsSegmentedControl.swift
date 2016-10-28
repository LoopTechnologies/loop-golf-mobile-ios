//
//  ReservationsSegmentedControl.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/3/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

@IBDesignable class ReservationsSegmentedControl: UIControl {
    
    fileprivate var labels = [UILabel]()
    var thumbView = UIView()
    var lineView = UIView()
    var pillView = UIView()
    
    var items: [String] = ["Requested", "Confirmed"] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex : Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        
        setupView()
    }
    
    func setupView() {
        
        setupLabels()
        insertSubview(thumbView, at: 0)
        
        // Setup the properties for the entire view of segmented controller. This section is where one should set the overall border for the controller, background color, corners, etc. Commented-out code below acts as reference to show.
        /*
         layer.cornerRadius = frame.height / 8
         layer.borderColor = UIColor.clearColor().CGColor //(red: 19/255, green: 86/255, blue:99/255, alpha: 1.0).CGColor
         layer.borderWidth = 2
         backgroundColor = UIColor.lightGrayColor() //UIColor.clearColor()
         */
        
    }
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            let label = UILabel(frame: CGRect.zero)
            label.text = items[index - 1]
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.font = UIFont(name: "AvenirNext-Regular", size: 17)
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = self.bounds
        let newWidth = selectFrame.width / CGFloat(items.count)
        selectFrame.size.width = newWidth
        thumbView.frame = selectFrame
        
        // Set the properties for the "shifting" view of the selected item in the segmented controller. This section is where one should set the border color for the thumbviews, background color, corners, etc. Commented-out code below acts as a reference to show.
        /*
         thumbView.backgroundColor = UIColor.darkGrayColor() //whiteColor()
         thumbView.layer.cornerRadius = thumbView.frame.height / 2
         */
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        //lineView.frame = CGRectMake((labelWidth * 0.15), labelHeight - 1.0, (labelWidth * 0.7), 1.5)
        lineView.frame = CGRect(x: (labelWidth * 0.1), y: labelHeight - 1.0, width: (labelWidth * 0.8), height: 2)
        lineView.backgroundColor = UIColor.white
        
        pillView.frame = CGRect (x: (labelWidth * 0.05), y: 0, width: (labelWidth * 0.9), height: labelHeight)
        pillView.backgroundColor = UIColor.clear //.groupTableViewBackgroundColor()
        pillView.layer.borderWidth = 1
        pillView.layer.borderColor = UIColor.white.cgColor
        pillView.layer.cornerRadius = thumbView.frame.height / 2
        
        thumbView.addSubview(lineView)
        //thumbView.addSubview(pillView)
        
        for index in 0...labels.count - 1 {
            let label = labels[index]
            
            let xPosition = CGFloat(index) * labelWidth
            label.frame = CGRect(x: xPosition, y: 0, width: labelWidth, height: labelHeight)
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        var calculatedIndex: Int?
        for(index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
    func displayNewSelectedIndex() {
        let label = labels[selectedIndex]
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping:  0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            self.thumbView.frame = label.frame
            }, completion: nil)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "selectedIndexNotification"), object: selectedIndex)
    }
    
    func addIndividualItemConstraints(_ items: [UIView], mainView: UIView, padding: CGFloat) {
        
        let constraints = mainView.constraints
        
        for (index, button) in items.enumerated() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == items.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -padding)
                
            }else{
                
                let nextButton = items[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: nextButton, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: -padding)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: mainView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: padding)
                
            }else{
                
                let prevButton = items[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: prevButton, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: padding)
                
                let firstItem = items[0]
                
                let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: NSLayoutRelation.equal, toItem: firstItem, attribute: .width, multiplier: 1.0  , constant: 0)
                
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
}
