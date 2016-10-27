//
//  SignUpPasswordViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/26/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class SignUpPasswordViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordPlaceholder: UILabel!
    @IBOutlet weak var passwordCellLabel: UILabel!
    @IBOutlet weak var passwordTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordPlaceholder: UILabel!
    @IBOutlet weak var confirmPasswordCellLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextFieldBottomConstraint: NSLayoutConstraint!

    var passwordIsValid = Bool()
    var passwordsMatch = Bool()
    var firstNameToSave = String()
    var lastNameToSave = String()
    var emailToSave = String()
    var phoneToSave = String()
    var profileImageURLToSave = String()
    var passwordToSave = String()
    
    // Receive data via segue.
    var firstNameReceivedAgain: String?
    var lastNameReceivedAgain: String?
    var emailReceivedAgain: String?
    var phoneReceivedAgain: String?
    var profileImageURLReceived: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Password"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.white]
        navigationController!.navigationBar.tintColor = UIColor.white
        
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
        
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self

        
        passwordTextField.tag = 1
        confirmPasswordTextField.tag = 2
        
        passwordTextFieldEmpty()
        confirmPasswordTextFieldEmpty()

        let nextButton = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: (#selector(EditProfileViewController.saveChanges)))
        nextButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], for: UIControlState())
        self.navigationItem.rightBarButtonItem = nextButton
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (passwordTextField.isFirstResponder) {
            passwordTextField.resignFirstResponder()
        } else if (confirmPasswordTextField.isFirstResponder) {
            confirmPasswordTextField.resignFirstResponder()
        }
    }
}

extension SignUpPasswordViewController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.tag == 1) {
            passwordTextFieldOccupied()
        } else if (textField.tag == 2) {
            confirmPasswordTextFieldOccupied()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.tag == 1) {
            passwordTextField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        } else if (textField.tag == 2) {
            confirmPasswordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.tag == 1) {
            passwordTextField.resignFirstResponder()
            if (passwordTextField.text == "") {
                passwordTextFieldEmpty()
            } else if (passwordTextField.text != "") {
                passwordTextFieldOccupied()
            }
        } else if (textField.tag == 2) {
            confirmPasswordTextField.resignFirstResponder()
            if (confirmPasswordTextField.text == "") {
                confirmPasswordTextFieldEmpty()
            } else if (confirmPasswordTextField.text != "") {
                confirmPasswordTextFieldOccupied()
            }
        }
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
    
    func confirmPasswordTextFieldEmpty() {
        confirmPasswordCellLabel.isHidden = true
        confirmPasswordPlaceholder.isHidden = false
        confirmPasswordTextFieldBottomConstraint.constant = 6
    }
    
    func confirmPasswordTextFieldOccupied() {
        confirmPasswordCellLabel.isHidden = false
        confirmPasswordPlaceholder.isHidden = true
        confirmPasswordTextFieldBottomConstraint.constant = 0
    }
    
    func evaluatePassword(_ password: String) -> Bool {
        if (password.characters.count < 6) {
            passwordIsValid = false
            return passwordIsValid
        }
        passwordIsValid = true
        return passwordIsValid
    }
    
    func evaluateForPasswordMatch(_ passwordString: String, confirmedPasswordString: String) -> Bool {
        if (passwordString == confirmedPasswordString) {
            passwordsMatch = true
            return passwordsMatch
        }
        passwordsMatch = false
        return passwordsMatch
    }
    
    func saveChanges() {
        
        // Start activity indicator
        
        evaluateForPasswordMatch(passwordTextField.text!, confirmedPasswordString: confirmPasswordTextField.text!)

        if (passwordsMatch == true) {
            evaluatePassword(passwordTextField.text!)
        } else if (passwordsMatch == false) {
            let notMatchingAlertController = UIAlertController(title: "", message:  "The two passwords you entered do not match. Both passwords must match to finish signing up.", preferredStyle: .alert)
            notMatchingAlertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            notMatchingAlertController.addAction(doneAction)
            self.present(notMatchingAlertController, animated: true) {
                notMatchingAlertController.view.tintColor = UIColor.black
            }
        }
        
        if (passwordIsValid == false) {
            let notLongEnoughAlertController = UIAlertController(title: "", message:  "Your password is not long enough. Passwords must be a minimum of 6 characters long.", preferredStyle: .alert)
            notLongEnoughAlertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            notLongEnoughAlertController.addAction(doneAction)
            self.present(notLongEnoughAlertController, animated: true) {
                notLongEnoughAlertController.view.tintColor = UIColor.black
            }
        } else if (passwordIsValid == true) {
            // Save information
            firstNameToSave = firstNameReceivedAgain!
            lastNameToSave = lastNameReceivedAgain!
            emailToSave = emailReceivedAgain!
            phoneToSave = phoneReceivedAgain!
            passwordToSave = passwordTextField.text!
            
            print(firstNameToSave)
            print(lastNameToSave)
            print(emailToSave)
            print(phoneToSave)
            print(passwordToSave)

            // Stop activity indicator
            
            let successAlertController = UIAlertController(title: "Welcome to Loop Golf.", message:  "\n We hope you're as excited to be here as we are to have you. Now get out there and play - with a Loop Golf caddie by your side, of course.", preferredStyle: .alert)
            successAlertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                self.performSegue(withIdentifier: "successfulSignUpSegue", sender: self)
            }
            successAlertController.addAction(doneAction)
            self.present(successAlertController, animated: true) {
                successAlertController.view.tintColor = UIColor.black
            }
        }
    }
}
