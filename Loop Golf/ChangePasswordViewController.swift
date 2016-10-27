//
//  ChangePasswordViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/18/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var currentPasswordTextField: UITextField!
    
    @IBOutlet weak var newPasswordHeaderCell: UITableViewCell!
    @IBOutlet weak var newPasswordTableViewCell: UITableViewCell!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordPlaceholder: UILabel!
    @IBOutlet weak var newPasswordCellLabel: UILabel!
    @IBOutlet weak var newPasswordTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirmNewPasswordTableViewCell: UITableViewCell!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordPlaceholder: UILabel!
    @IBOutlet weak var confirmNewPasswordCellLabel: UILabel!
    @IBOutlet weak var confirmNewPasswordTextFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var newPasswordFooterCell: UITableViewCell!
    

    var userIsEditingCurrentPassword = Bool()
    var currentPasswordIsValid = Bool()
    var userIsEditingNewPassword = Bool()
    var newAndConfirmedPasswordValid = Bool()
    var passwordToSave = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Change Password"
        navigationController!.navigationBar.tintColor = UIColor.black
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        
        let saveButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: (#selector(ChangePasswordViewController.rightBarButtonPressed)))
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], for: UIControlState())
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        currentPasswordTextField.delegate = self
        currentPasswordTextField.text = ""
        currentPasswordTextField.becomeFirstResponder()
        newPasswordHeaderCell.isHidden = true
        newPasswordTableViewCell.isHidden = true
        newPasswordTextField.delegate = self
        newPasswordTextField.text = ""
        confirmNewPasswordTableViewCell.isHidden = true
        confirmNewPasswordTextField.delegate = self
        confirmNewPasswordTextField.text = ""
        newPasswordFooterCell.isHidden = true
        
        userIsEditingCurrentPassword = true
        userIsEditingNewPassword = false
        
        newPasswordTextFieldEmpty()
        confirmNewPasswordTextFieldEmpty()
        
        currentPasswordTextField.tag = 1
        newPasswordTextField.tag = 2
        confirmNewPasswordTextField.tag = 3
    }
}

extension ChangePasswordViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    @IBAction func currentPasswordTextFieldEditingChanged(_ sender: AnyObject) {
        if (currentPasswordTextField.text!.characters.count < 6) {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func validateCurrentPassword(_ currentPassword: String) -> Bool {
        
        // Validate current password against password in Firebase DB.
        //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
        currentPasswordIsValid = true
        // --------------------------------------------------------------------------------//
        
        return currentPasswordIsValid
    }
    
    func verifyNewPassword(_ newPassword: String, confirmedNewPassword: String) -> Bool {
        if (newPassword != confirmedNewPassword) {
            let alertController = UIAlertController(title: "", message:  "The two passwords that you entered do not match. Passwords must match to save changes.", preferredStyle: .alert)
            alertController.view.tintColor = UIColor.black
            let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.present(alertController, animated: true) {
                alertController.view.tintColor = UIColor.black
            }
        } else if (newPassword == confirmedNewPassword) {
            if (newPassword.characters.count < 6 && confirmedNewPassword.characters.count < 6) {
                let alertController = UIAlertController(title: "", message:  "The password that you entered is not long enough. Your new password must be at least 6 characters long to save changes.", preferredStyle: .alert)
                alertController.view.tintColor = UIColor.black
                let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                }
                alertController.addAction(doneAction)
                self.present(alertController, animated: true) {
                    alertController.view.tintColor = UIColor.black
                }
            } else {
                // Save changes to account information.
                passwordToSave = newPassword
                print(passwordToSave)
                navigationController?.popViewController(animated: true)
            }
        }
        
        return newAndConfirmedPasswordValid
    }
    
    func rightBarButtonPressed() {
        validateCurrentPassword(currentPasswordTextField.text!)
        
        if (userIsEditingCurrentPassword == true) {
            if (currentPasswordIsValid == false) {
                let alertController = UIAlertController(title: "", message:  "You entered an invalid password. You must enter your current password to create a new one.", preferredStyle: .alert)
                alertController.view.tintColor = UIColor.black
                let doneAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                }
                alertController.addAction(doneAction)
                self.present(alertController, animated: true) {
                    alertController.view.tintColor = UIColor.black
                }
            } else {
                newPasswordHeaderCell.isHidden = false
                newPasswordTableViewCell.isHidden = false
                confirmNewPasswordTableViewCell.isHidden = false
                newPasswordFooterCell.isHidden = false
                currentPasswordTextField.isUserInteractionEnabled = false
                self.navigationItem.rightBarButtonItem?.title = "Save"
                userIsEditingCurrentPassword = false
                userIsEditingNewPassword = true
                newPasswordTextField.becomeFirstResponder()
            }
        } else if (userIsEditingNewPassword == true) {
            verifyNewPassword(newPasswordTextField.text!, confirmedNewPassword: confirmNewPasswordTextField.text!)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.tag == 2) {
            newPasswordTextFieldOccupied()
        } else if (textField.tag == 3) {
            confirmNewPasswordTextFieldOccupied()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.tag == 1) {
            rightBarButtonPressed()
        } else if (textField.tag == 2) {
            newPasswordTextField.resignFirstResponder()
        } else if (textField.tag == 3) {
            confirmNewPasswordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.tag == 2) {
            newPasswordTextField.resignFirstResponder()
            if (newPasswordTextField.text == "") {
                newPasswordTextFieldEmpty()
            } else if (newPasswordTextField.text != "") {
                newPasswordTextFieldOccupied()
            }
        } else if (textField.tag == 3) {
            confirmNewPasswordTextField.resignFirstResponder()
            if (confirmNewPasswordTextField.text == "") {
                confirmNewPasswordTextFieldEmpty()
            } else if (confirmNewPasswordTextField.text != "") {
                confirmNewPasswordTextFieldOccupied()
            }
        }
    }
    
    func newPasswordTextFieldEmpty() {
        newPasswordCellLabel.isHidden = true
        newPasswordPlaceholder.isHidden = false
        newPasswordTextFieldBottomConstraint.constant = 6
    }
    
    func newPasswordTextFieldOccupied() {
        newPasswordCellLabel.isHidden = false
        newPasswordPlaceholder.isHidden = true
        newPasswordTextFieldBottomConstraint.constant = 0
    }
    
    func confirmNewPasswordTextFieldEmpty() {
        confirmNewPasswordCellLabel.isHidden = true
        confirmNewPasswordPlaceholder.isHidden = false
        confirmNewPasswordTextFieldBottomConstraint.constant = 6
    }
    
    func confirmNewPasswordTextFieldOccupied() {
        confirmNewPasswordCellLabel.isHidden = false
        confirmNewPasswordPlaceholder.isHidden = true
        confirmNewPasswordTextFieldBottomConstraint.constant = 0
    }
}
