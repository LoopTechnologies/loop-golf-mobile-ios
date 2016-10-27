//
//  SignUpInformationViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/25/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class SignUpInformationViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNamePlaceholder: UILabel!
    @IBOutlet weak var firstNameCellLabel: UILabel!
    @IBOutlet weak var firstNameTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var lastNamePlaceholder: UILabel!
    @IBOutlet weak var lastNameCellLabel: UILabel!
    @IBOutlet weak var lastNameTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailPlaceholder: UILabel!
    @IBOutlet weak var emailCellLabel: UILabel!
    @IBOutlet weak var emailTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var confirmEmailPlaceholder: UILabel!
    @IBOutlet weak var confirmEmailCellLabel: UILabel!
    @IBOutlet weak var confirmEmailTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phonePlaceholder: UILabel!
    @IBOutlet weak var phoneCellLabel: UILabel!
    @IBOutlet weak var phoneTextFieldBottomConstraint: NSLayoutConstraint!
    
    var userHasEditedATextField: Bool = false
    var emailIsValid = Bool()
    var emailsMatch = Bool()
    var phoneToValidate = String()
    var firstNameForSegue = String()
    var lastNameForSegue = String()
    var emailForSegue = String()
    var phoneForSegue = String()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.white]
        navigationController!.navigationBar.tintColor = UIColor.white

        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
    
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        confirmEmailTextField.delegate = self
        phoneTextField.delegate = self
        
        firstNameTextField.tag = 1
        lastNameTextField.tag = 2
        emailTextField.tag = 3
        confirmEmailTextField.tag = 4
        phoneTextField.tag = 5
        
        firstNameTextFieldEmpty()
        lastNameTextFieldEmpty()
        emailTextFieldEmpty()
        confirmEmailTextFieldEmpty()
        phoneTextFieldEmpty()
        
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: (#selector(EditProfileViewController.saveChanges)))
        nextButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], for: UIControlState())
        self.navigationItem.rightBarButtonItem = nextButton
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (firstNameTextField.isFirstResponder) {
            firstNameTextField.resignFirstResponder()
        } else if (lastNameTextField.isFirstResponder) {
            lastNameTextField.resignFirstResponder()
        } else if (emailTextField.isFirstResponder) {
            emailTextField.resignFirstResponder()
        } else if (confirmEmailTextField.isFirstResponder) {
            confirmEmailTextField.resignFirstResponder()
        } else if (phoneTextField.isFirstResponder) {
            phoneTextField.resignFirstResponder()
        }
    }
}

extension SignUpInformationViewController {
    
    @IBAction func dismissVCButtonPressed(_ sender: UIBarButtonItem) {
        evaluateTextFieldsForUnsavedChanges()
        
        switch(userHasEditedATextField) {
        case true:
            let alertController = UIAlertController(title: "", message: "You'll lose any information that you've entered so far if you decide to exit the sign up process. Would you like to exit?", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "Exit Sign Up", style: .default) { (action) in
                self.dismiss(animated: true, completion: {})
            }
            alertController.addAction(doneAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        case false:
           self.dismiss(animated: true, completion: {})
        default:
            break
        
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.tag == 1) {
            firstNameTextFieldOccupied()
        } else if (textField.tag == 2) {
            lastNameTextFieldOccupied()
        } else if (textField.tag == 3) {
            emailTextFieldOccupied()
        } else if (textField.tag == 4) {
            confirmEmailTextFieldOccupied()
        } else if (textField.tag == 5) {
            phoneTextFieldOccupied()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.tag == 1) {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        } else if (textField.tag == 2) {
            lastNameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        } else if (textField.tag == 3) {
            emailTextField.resignFirstResponder()
            confirmEmailTextField.becomeFirstResponder()
        } else if (textField.tag == 4) {
            confirmEmailTextField.resignFirstResponder()
            phoneTextField.becomeFirstResponder()
        } else if (textField.tag == 5) {
            phoneTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.tag == 1) {
            firstNameTextField.resignFirstResponder()
            if (firstNameTextField.text == "") {
                firstNameTextFieldEmpty()
            } else if (firstNameTextField.text != "") {
                firstNameTextFieldOccupied()
            }
        } else if (textField.tag == 2) {
            lastNameTextField.resignFirstResponder()
            if (lastNameTextField.text == "") {
                lastNameTextFieldEmpty()
            } else if (lastNameTextField.text != "") {
                lastNameTextFieldOccupied()
            }
        } else if (textField.tag == 3) {
            emailTextField.resignFirstResponder()
            if (emailTextField.text == "") {
                emailTextFieldEmpty()
            } else if (emailTextField.text != "") {
                emailTextFieldOccupied()
            }
        } else if (textField.tag == 4) {
            confirmEmailTextField.resignFirstResponder()
            if (confirmEmailTextField.text == "") {
                confirmEmailTextFieldEmpty()
            } else if (confirmEmailTextField.text != "") {
                confirmEmailTextFieldOccupied()
            }
        } else if (textField.tag == 5) {
            phoneTextField.resignFirstResponder()
            if (phoneTextField.text == "") {
                phoneTextFieldEmpty()
            } else if (phoneTextField.text != "") {
                phoneTextFieldOccupied()
            }
        }
    }
    
    func firstNameTextFieldEmpty() {
        firstNameCellLabel.isHidden = true
        firstNamePlaceholder.isHidden = false
        firstNameTextFieldBottomConstraint.constant = 6
    }
    
    func firstNameTextFieldOccupied() {
        firstNameCellLabel.isHidden = false
        firstNamePlaceholder.isHidden = true
        firstNameTextFieldBottomConstraint.constant = 0
    }
    
    func lastNameTextFieldEmpty() {
        lastNameCellLabel.isHidden = true
        lastNamePlaceholder.isHidden = false
        lastNameTextFieldBottomConstraint.constant = 6
    }
    
    func lastNameTextFieldOccupied() {
        lastNameCellLabel.isHidden = false
        lastNamePlaceholder.isHidden = true
        lastNameTextFieldBottomConstraint.constant = 0
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
    
    func confirmEmailTextFieldEmpty() {
        confirmEmailCellLabel.isHidden = true
        confirmEmailPlaceholder.isHidden = false
        confirmEmailTextFieldBottomConstraint.constant = 6
    }
    
    func confirmEmailTextFieldOccupied() {
        confirmEmailCellLabel.isHidden = false
        confirmEmailPlaceholder.isHidden = true
        confirmEmailTextFieldBottomConstraint.constant = 0
    }
    
    func phoneTextFieldEmpty() {
        phoneCellLabel.isHidden = true
        phonePlaceholder.isHidden = false
        phoneTextFieldBottomConstraint.constant = 6
    }
    
    func phoneTextFieldOccupied() {
        phoneCellLabel.isHidden = false
        phonePlaceholder.isHidden = true
        phoneTextFieldBottomConstraint.constant = 0
    }
    
    func evaluateTextFieldsForUnsavedChanges() -> Bool {
        if (firstNameTextField.text != "" || lastNameTextField.text != "" || emailTextField.text != "" || phoneTextField.text != "") {
            userHasEditedATextField = true
            return userHasEditedATextField
        }
        userHasEditedATextField = false
        return userHasEditedATextField
    }
    
    func validateEmail(_ emailString: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        emailIsValid = emailPredicate.evaluate(with: emailString)
        return emailIsValid
    }
    
    func confirmedEmailMatches(_ emailString: String, confirmedEmailString: String) -> Bool {
        if (emailString == confirmedEmailString) {
            emailsMatch = true
            return emailsMatch
        }
        emailsMatch = false
        return emailsMatch
    }
    
    func saveChanges() {
        validateEmail(emailTextField.text!)
        confirmedEmailMatches(emailTextField.text!, confirmedEmailString: confirmEmailTextField.text!)
        phoneToValidate = phoneTextField.text!
        
        if (firstNameTextField.text == "" || lastNameTextField.text == "") {
            let alertController = UIAlertController(title: "", message:  "You forgot to enter a first and/or last name. Enter both to continue.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        } else if (emailIsValid == false) {
            let alertController = UIAlertController(title: "", message:  "The email you've chosen is invalid. You must enter a valid email to continue.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        } else if (emailsMatch == false) {
            let alertController = UIAlertController(title: "", message:  "The two emails you entered do not match. Both must match to continue.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        } else if (phoneToValidate.characters.count <= 9) {
            let alertController = UIAlertController(title: "", message:  "You must enter a valid phone number to continue.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        } else {
            // Save changes to account information.
            firstNameForSegue = firstNameTextField.text!
            lastNameForSegue = lastNameTextField.text!
            emailForSegue = emailTextField.text!
            phoneForSegue = phoneTextField.text!
            print(firstNameForSegue)
            print(lastNameForSegue)
            print(emailForSegue)
            print(phoneForSegue)
            performSegue(withIdentifier: "toSignUpProfileImageSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSignUpProfileImageSegue") {
            let destinationVC = segue.destination as! SignUpProfileImageViewController
            
            destinationVC.firstNameReceived = firstNameForSegue
            destinationVC.lastNameReceived = lastNameForSegue
            destinationVC.emailReceived = emailForSegue
            destinationVC.phoneReceived = phoneForSegue
        }
    }
    
    
}
