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
        navigationController!.navigationBar.tintColor = UIColor.blackColor()
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        
        let saveButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: ("rightBarButtonPressed"))
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        currentPasswordTextField.delegate = self
        currentPasswordTextField.text = ""
        currentPasswordTextField.becomeFirstResponder()
        newPasswordHeaderCell.hidden = true
        newPasswordTableViewCell.hidden = true
        newPasswordTextField.delegate = self
        newPasswordTextField.text = ""
        confirmNewPasswordTableViewCell.hidden = true
        confirmNewPasswordTextField.delegate = self
        confirmNewPasswordTextField.text = ""
        newPasswordFooterCell.hidden = true
        
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
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    @IBAction func currentPasswordTextFieldEditingChanged(sender: AnyObject) {
        if (currentPasswordTextField.text!.characters.count < 6) {
            self.navigationItem.rightBarButtonItem?.enabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.enabled = true
        }
    }
    
    func validateCurrentPassword(currentPassword: String) -> Bool {
        
        // Validate current password against password in Firebase DB.
        //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
        currentPasswordIsValid = true
        // --------------------------------------------------------------------------------//
        
        return currentPasswordIsValid
    }
    
    func verifyNewPassword(newPassword: String, confirmedNewPassword: String) -> Bool {
        if (newPassword != confirmedNewPassword) {
            let alertController = UIAlertController(title: "", message:  "The two passwords that you entered do not match. Passwords must match to save changes.", preferredStyle: .Alert)
            alertController.view.tintColor = UIColor.blackColor()
            let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
            }
            alertController.addAction(doneAction)
            self.presentViewController(alertController, animated: true) {
                alertController.view.tintColor = UIColor.blackColor()
            }
        } else if (newPassword == confirmedNewPassword) {
            if (newPassword.characters.count < 6 && confirmedNewPassword.characters.count < 6) {
                let alertController = UIAlertController(title: "", message:  "The password that you entered is not long enough. Your new password must be at least 6 characters long to save changes.", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor.blackColor()
                let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                }
                alertController.addAction(doneAction)
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor.blackColor()
                }
            } else {
                // Save changes to account information.
                passwordToSave = newPassword
                print(passwordToSave)
                navigationController?.popViewControllerAnimated(true)
            }
        }
        
        return newAndConfirmedPasswordValid
    }
    
    func rightBarButtonPressed() {
        validateCurrentPassword(currentPasswordTextField.text!)
        
        if (userIsEditingCurrentPassword == true) {
            if (currentPasswordIsValid == false) {
                let alertController = UIAlertController(title: "", message:  "You entered an invalid password. You must enter your current password to create a new one.", preferredStyle: .Alert)
                alertController.view.tintColor = UIColor.blackColor()
                let doneAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                }
                alertController.addAction(doneAction)
                self.presentViewController(alertController, animated: true) {
                    alertController.view.tintColor = UIColor.blackColor()
                }
            } else {
                newPasswordHeaderCell.hidden = false
                newPasswordTableViewCell.hidden = false
                confirmNewPasswordTableViewCell.hidden = false
                newPasswordFooterCell.hidden = false
                currentPasswordTextField.userInteractionEnabled = false
                self.navigationItem.rightBarButtonItem?.title = "Save"
                userIsEditingCurrentPassword = false
                userIsEditingNewPassword = true
                newPasswordTextField.becomeFirstResponder()
            }
        } else if (userIsEditingNewPassword == true) {
            verifyNewPassword(newPasswordTextField.text!, confirmedNewPassword: confirmNewPasswordTextField.text!)
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField.tag == 2) {
            newPasswordTextFieldOccupied()
        } else if (textField.tag == 3) {
            confirmNewPasswordTextFieldOccupied()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField.tag == 1) {
            rightBarButtonPressed()
        } else if (textField.tag == 2) {
            newPasswordTextField.resignFirstResponder()
        } else if (textField.tag == 3) {
            confirmNewPasswordTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
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
        newPasswordCellLabel.hidden = true
        newPasswordPlaceholder.hidden = false
        newPasswordTextFieldBottomConstraint.constant = 6
    }
    
    func newPasswordTextFieldOccupied() {
        newPasswordCellLabel.hidden = false
        newPasswordPlaceholder.hidden = true
        newPasswordTextFieldBottomConstraint.constant = 0
    }
    
    func confirmNewPasswordTextFieldEmpty() {
        confirmNewPasswordCellLabel.hidden = true
        confirmNewPasswordPlaceholder.hidden = false
        confirmNewPasswordTextFieldBottomConstraint.constant = 6
    }
    
    func confirmNewPasswordTextFieldOccupied() {
        confirmNewPasswordCellLabel.hidden = false
        confirmNewPasswordPlaceholder.hidden = true
        confirmNewPasswordTextFieldBottomConstraint.constant = 0
    }
}
