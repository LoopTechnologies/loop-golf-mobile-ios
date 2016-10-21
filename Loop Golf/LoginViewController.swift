//
//  LoginViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/21/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var emailBackgroundView: UIView!
    @IBOutlet weak var passwordBackgroundView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailPlaceholder: UILabel!
    @IBOutlet weak var emailCellLabel: UILabel!
    @IBOutlet weak var emailTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordPlaceholder: UILabel!
    @IBOutlet weak var passwordCellLabel: UILabel!
    @IBOutlet weak var passwordTextFieldBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        backgroundButton.hidden = true
        
        emailTextField.tag = 1
        passwordTextField.tag = 2
        
        emailBackgroundView.layer.cornerRadius = 8
        emailBackgroundView.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6).CGColor

        passwordBackgroundView.layer.cornerRadius = 8
        passwordBackgroundView.layer.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6).CGColor

        loginButton.layer.cornerRadius = 8
        loginButton.layer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.75).CGColor
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.borderWidth = 1
        
        if (emailTextField.text == "") {
            emailTextFieldEmpty()
        } else if (emailTextField.text != "") {
            emailTextFieldOccupied()
        }
        
        if (passwordTextField.text == "") {
            passwordTextFieldEmpty()
        } else if (passwordTextField.text != "") {
            passwordTextFieldOccupied()
        }
    }
}

extension LoginViewController {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField.tag == 1) {
            backgroundButton.hidden = false
            emailTextFieldOccupied()
        } else if (textField.tag == 2) {
            backgroundButton.hidden = false
            passwordTextFieldOccupied()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField.tag == 1) {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if (textField.tag == 2) {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField.tag == 1) {
            emailTextField.resignFirstResponder()
            if (emailTextField.text == "") {
                emailTextFieldEmpty()
            } else if (emailTextField.text != "") {
                emailTextFieldOccupied()
            }
        } else if (textField.tag == 2) {
            passwordTextField.resignFirstResponder()
            if (passwordTextField.text == "") {
                passwordTextFieldEmpty()
            } else if (passwordTextField.text != "") {
                passwordTextFieldOccupied()
            }
        }
        backgroundButton.hidden = true
    }
    
    @IBAction func backgroundButtonPressed(sender: AnyObject) {
        if (emailTextField.isFirstResponder()) {
            emailTextField.resignFirstResponder()
        } else if (passwordTextField.isFirstResponder()) {
            passwordTextField.resignFirstResponder()
            
        }
    }
    
    func emailTextFieldEmpty() {
        emailCellLabel.hidden = true
        emailPlaceholder.hidden = false
        emailTextFieldBottomConstraint.constant = 6
    }
    
    func emailTextFieldOccupied() {
        emailCellLabel.hidden = false
        emailPlaceholder.hidden = true
        emailTextFieldBottomConstraint.constant = 0
    }
    
    func passwordTextFieldEmpty() {
        passwordCellLabel.hidden = true
        passwordPlaceholder.hidden = false
        passwordTextFieldBottomConstraint.constant = 6
    }
    
    func passwordTextFieldOccupied() {
        passwordCellLabel.hidden = false
        passwordPlaceholder.hidden = true
        passwordTextFieldBottomConstraint.constant = 0
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func signUpButtonPressed(sender: AnyObject) {
    }
    
}
