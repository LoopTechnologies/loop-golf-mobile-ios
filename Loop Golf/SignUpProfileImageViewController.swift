//
//  SignUpProfileImageViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/26/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class SignUpProfileImageViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    // Receive data via segue.
    var firstNameReceived: String?
    var lastNameReceived: String?
    var emailReceived: String?
    var phoneReceived: String?
    
    // Send data via segue.
    var firstNameForSegueAgain = String()
    var lastNameForSegueAgain = String()
    var emailForSegueAgain = String()
    var phoneForSegueAgain = String()
    var profileImageURLForSegue = String()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Upload Profile Picture"
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name:"AvenirNext-Regular", size: 26)!, NSForegroundColorAttributeName: UIColor.white]
        navigationController!.navigationBar.tintColor = UIColor.white
        
        welcomeLabel.text = "Nice to meet you, \(firstNameReceived!)"
        profileImageView.layer.cornerRadius = 8
        
        continueButtonDisabled()
        continueButton.layer.cornerRadius = 8
    }
}

extension SignUpProfileImageViewController {
    
    @IBAction func infoButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "toInfoSegue", sender: self)
    }
    
    @IBAction func profileImageButtonPressed(_ sender: AnyObject) {
        let actionSheetController = UIAlertController(title: nil, message:  nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let newPhotoAction = UIAlertAction(title: "Take photo", style: .default) { (action) in
            // Launch camera.
        }
        actionSheetController.addAction(newPhotoAction)
        let cameraRollAction = UIAlertAction(title: "Choose from camera roll", style: .default) { (action) in
        }
        actionSheetController.addAction(cameraRollAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true) {
            actionSheetController.view.tintColor = UIColor.black
        }
    }
    
    @IBAction func skipButtonPressed(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "", message:  "You don't have to upload a profile picture now, but you won't be able to make reservations until you do so. Are you sure you want to skip this step? It only takes a moment.", preferredStyle: .alert)
        alertController.view.tintColor = UIColor.black
        let skipAction = UIAlertAction(title: "Yes, skip this step", style: .default) { (action) in
            self.performSegue(withIdentifier: "toSignUpPasswordSegue", sender: self)
        }
        alertController.addAction(skipAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {
            alertController.view.tintColor = UIColor.black
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: AnyObject) {
    }
    
    func continueButtonDisabled() {
        continueButton.isEnabled = false
        continueButton.setTitleColor(UIColor.groupTableViewBackground, for: UIControlState())
        continueButton.layer.backgroundColor = UIColor.lightGray.cgColor
    }
    
    func continueButtonEnabled() {
        continueButton.isEnabled = true
        continueButton.setTitleColor(UIColor.white, for: UIControlState())
        continueButton.layer.backgroundColor = UIColor.black.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSignUpPasswordSegue") {
            let destinationVC = segue.destination as! SignUpPasswordViewController
            firstNameForSegueAgain = firstNameReceived!
            lastNameForSegueAgain = lastNameReceived!
            emailForSegueAgain = emailReceived!
            phoneForSegueAgain = phoneReceived!
            
            destinationVC.firstNameReceivedAgain = firstNameForSegueAgain
            destinationVC.lastNameReceivedAgain = lastNameForSegueAgain
            destinationVC.emailReceivedAgain = emailForSegueAgain
            destinationVC.phoneReceivedAgain = phoneForSegueAgain
        }
    }
    
}
