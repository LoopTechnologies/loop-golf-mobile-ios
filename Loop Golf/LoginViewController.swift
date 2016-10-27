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
        
        backgroundButton.isHidden = true
        
        emailTextField.tag = 1
        passwordTextField.tag = 2
        
        emailBackgroundView.layer.cornerRadius = 8
        emailBackgroundView.layer.backgroundColor = UIColor.white.withAlphaComponent(0.6).cgColor

        passwordBackgroundView.layer.cornerRadius = 8
        passwordBackgroundView.layer.backgroundColor = UIColor.white.withAlphaComponent(0.6).cgColor

        loginButton.layer.cornerRadius = 8
        loginButton.layer.backgroundColor = UIColor.black.withAlphaComponent(0.75).cgColor
        loginButton.layer.borderColor = UIColor.white.cgColor
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.tag == 1) {
            backgroundButton.isHidden = false
            emailTextFieldOccupied()
        } else if (textField.tag == 2) {
            backgroundButton.isHidden = false
            passwordTextFieldOccupied()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.tag == 1) {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if (textField.tag == 2) {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
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
        backgroundButton.isHidden = true
    }
    
    @IBAction func backgroundButtonPressed(_ sender: AnyObject) {
        if (emailTextField.isFirstResponder) {
            emailTextField.resignFirstResponder()
        } else if (passwordTextField.isFirstResponder) {
            passwordTextField.resignFirstResponder()
            
        }
    }
    
    func emailTextFieldEmpty() {
        emailCellLabel.isHidden = true
        emailPlaceholder.isHidden = false
        emailTextFieldBottomConstraint.constant = 6
    }
    
    func emailTextFieldOccupied() {
        emailCellLabel.isHidden = false
        emailPlaceholder.isHidden = true
        emailTextFieldBottomConstraint.constant = 0
    }
    
    func passwordTextFieldEmpty() {
        passwordCellLabel.isHidden = true
        passwordPlaceholder.isHidden = false
        passwordTextFieldBottomConstraint.constant = 6
    }
    
    func passwordTextFieldOccupied() {
        passwordCellLabel.isHidden = false
        passwordPlaceholder.isHidden = true
        passwordTextFieldBottomConstraint.constant = 0
    }
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
    }
    
    @IBAction func signUpButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "toSignUpSegue", sender: self)
    }
    
}
