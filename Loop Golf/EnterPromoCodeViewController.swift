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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        promoCodeTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.tintColor = UIColor.black
        
        applyButtonDisabled()
        applyButton.layer.cornerRadius = 20
    }
}

extension EnterPromoCodeViewController {
    
    func applyButtonDisabled() {
        applyButton.isEnabled = false
        applyButton.setTitleColor(UIColor.lightGray, for: UIControlState())
        applyButton.layer.backgroundColor = UIColor.groupTableViewBackground.cgColor
    }
    
    func applyButtonEnabled() {
        applyButton.isEnabled = true
        applyButton.setTitleColor(UIColor.white, for: UIControlState())
        applyButton.layer.backgroundColor = UIColor.black.cgColor
    }
    
    @IBAction func promoCodeTextFieldEditingChanged(_ sender: AnyObject) {
        if (promoCodeTextField.text!.characters.count < 1) {
            applyButtonDisabled()
        } else {
            applyButtonEnabled()
        }
    }
    
    @IBAction func applyButtonPressed(_ sender: AnyObject) {
        evaluatePromoCode(promoCodeTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        evaluatePromoCode(promoCodeTextField.text!)
        return true
    }
    
    func evaluatePromoCode(_ enteredPromoCode: String) -> Bool {
        // TODO: Query FirebaseDB for enteredPromoCode.
        if (enteredPromoCode == promoCode) {
            let alertController = UIAlertController(title: "", message: "Your promo code has been applied.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.promoCodeTextField.resignFirstResponder()
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        } else {
            let alertController = UIAlertController(title: "", message: "The promo code you entered is invalid. Please try something else.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let tryAgainAction = UIAlertAction(title: "Try Again", style: .cancel) { (action) in
                self.promoCodeTextField.text = ""
                self.applyButtonDisabled()
                self.promoCodeTextField.becomeFirstResponder()
            }
            alertController.addAction(tryAgainAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        }
        return true
    }
}
