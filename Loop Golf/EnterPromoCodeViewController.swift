//
//  EnterPromoCodeViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/19/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class EnterPromoCodeViewController: UIViewController, UITextFieldDelegate {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var promoCode = "ABC123"
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var promoCodeTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        promoCodeTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.tintColor = UIColor.blackColor()
        
        applyButtonDisabled()
        applyButton.layer.cornerRadius = 20
    }
}

extension EnterPromoCodeViewController {
    
    func applyButtonDisabled() {
        applyButton.enabled = false
        applyButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        applyButton.layer.backgroundColor = UIColor.groupTableViewBackgroundColor().CGColor
    }
    
    func applyButtonEnabled() {
        applyButton.enabled = true
        applyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        applyButton.layer.backgroundColor = UIColor.blackColor().CGColor
    }
    
    @IBAction func promoCodeTextFieldEditingChanged(sender: AnyObject) {
        if (promoCodeTextField.text!.characters.count < 1) {
            applyButtonDisabled()
        } else {
            applyButtonEnabled()
        }
    }
    
    @IBAction func applyButtonPressed(sender: AnyObject) {
        evaluatePromoCode(promoCodeTextField.text!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        evaluatePromoCode(promoCodeTextField.text!)
        return true
    }
    
    func evaluatePromoCode(enteredPromoCode: String) -> Bool {
        // TODO: Query FirebaseDB for enteredPromoCode.
        if (enteredPromoCode == promoCode) {
            let alertController = UIAlertController(title: "", message: "Your promo code has been applied.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor.blackColor()
            let doneAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.promoCodeTextField.resignFirstResponder()
                self.navigationController?.popViewControllerAnimated(true)
            }
            alertController.addAction(doneAction)
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor.blackColor()
            }
        } else {
            let alertController = UIAlertController(title: "", message: "The promo code you entered is invalid. Please try something else.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor.blackColor()
            let tryAgainAction = UIAlertAction(title: "Try Again", style: .Cancel) { (action) in
                self.promoCodeTextField.text = ""
                self.applyButtonDisabled()
                self.promoCodeTextField.becomeFirstResponder()
            }
            alertController.addAction(tryAgainAction)
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor.blackColor()
            }
        }
        return true
    }
}
