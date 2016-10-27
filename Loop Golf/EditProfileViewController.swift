//
//  EditProfileViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/18/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController, UITextFieldDelegate {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var firstName = "Matt"
    var lastName = "Hills"
    var email = "m@gmail.com"
    var phone = "2817317323"
    
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var profileImageView: UIImageView!
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
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phonePlaceholder: UILabel!
    @IBOutlet weak var phoneCellLabel: UILabel!
    @IBOutlet weak var phoneTextFieldBottomConstraint: NSLayoutConstraint!
    
    var emailIsValid = Bool()
    var phoneToValidate = String()
    var firstNameToSave = String()
    var lastNameToSave = String()
    var emailToSave = String()
    var phoneToSave = String()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Profile"
        navigationController!.navigationBar.tintColor = UIColor.black
        tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0)
        
        profileImageView.layer.cornerRadius = 8
        firstNameTextField.delegate = self
        firstNameTextField.text = firstName
        lastNameTextField.delegate = self
        lastNameTextField.text = lastName
        emailTextField.delegate = self
        emailTextField.text = email
        phoneTextField.delegate = self
        phoneTextField.text = phone
        
        firstNameTextField.tag = 1
        lastNameTextField.tag = 2
        emailTextField.tag = 3
        phoneTextField.tag = 4
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: (#selector(EditProfileViewController.saveChanges)))
        doneButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], for: UIControlState())
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        if (firstNameTextField.text == "") {
            firstNameTextFieldEmpty()
        } else if (firstNameTextField.text != "") {
            firstNameTextFieldOccupied()
        }
        
        if (lastNameTextField.text == "") {
            lastNameTextFieldEmpty()
        } else if (lastNameTextField.text != "") {
            lastNameTextFieldOccupied()
        }
        
        if (emailTextField.text == "") {
            emailTextFieldEmpty()
        } else if (emailTextField.text != "") {
            emailTextFieldOccupied()
        }
        
        if (phoneTextField.text == "") {
            phoneTextFieldEmpty()
        } else if (phoneTextField.text != "") {
            phoneTextFieldOccupied()
        }
    }
}

extension EditProfileViewController {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.tag == 1) {
            firstNameTextFieldOccupied()
        } else if (textField.tag == 2) {
            lastNameTextFieldOccupied()
        } else if (textField.tag == 3) {
            emailTextFieldOccupied()
        } else if (textField.tag == 4) {
            phoneTextFieldOccupied()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.tag == 1) {
            firstNameTextField.resignFirstResponder()
        } else if (textField.tag == 2) {
            lastNameTextField.resignFirstResponder()
        } else if (textField.tag == 3) {
            emailTextField.resignFirstResponder()
        } else if (textField.tag == 4) {
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
    
    func validateEmail(_ emailString: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        emailIsValid = emailPredicate.evaluate(with: emailString)
        return emailIsValid
    }
    
    func saveChanges() {
        validateEmail(emailTextField.text!)
        phoneToValidate = phoneTextField.text!
        
        if (firstNameTextField.text == "" || lastNameTextField.text == "") {
            let alertController = UIAlertController(title: "", message:  "You must enter a first and last name to save changes.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        } else if (emailIsValid == false) {
            let alertController = UIAlertController(title: "", message:  "You must enter a valid email to save changes.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        } else if (phoneToValidate.characters.count <= 9) {
            let alertController = UIAlertController(title: "", message:  "You must enter a valid phone number to save changes.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        } else {
            // Save changes to account information.
            firstNameToSave = firstNameTextField.text!
            lastNameToSave = lastNameTextField.text!
            emailToSave = emailTextField.text!
            phoneToSave = phoneTextField.text!
            print(firstNameToSave)
            print(lastNameToSave)
            print(emailToSave)
            print(phoneToSave)
            navigationController?.popViewController(animated: true)
        }
    }
}
