//
//  BecomeACaddieViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/19/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class BecomeACaddieViewController: UIViewController {
    
    @IBOutlet weak var backgroundView1: UIView!
    @IBOutlet weak var backgroundView2: UIView!
    @IBOutlet weak var backgroundView3: UIView!
    @IBOutlet weak var backgroundView4: UIView!
    @IBOutlet weak var learnMoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Caddie With Loop Golf"
        navigationController!.navigationBar.tintColor = UIColor.black
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        backgroundView1.layer.cornerRadius = 8
        backgroundView2.layer.cornerRadius = 8
        backgroundView3.layer.cornerRadius = 8
        backgroundView4.layer.cornerRadius = 8
        
        learnMoreButton.layer.backgroundColor = UIColor.black.withAlphaComponent(0.75).cgColor
        learnMoreButton.layer.cornerRadius = 8
        learnMoreButton.layer.borderColor = UIColor.white.cgColor
        learnMoreButton.layer.borderWidth = 1
    }
}

extension BecomeACaddieViewController {
    
    @IBAction func learnMoreButtonPressed(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Go to LoopGolf.com?", message: "\n More information about how to become a caddie, including the sign up process, is found on our website. Would you like to be redirected there?", preferredStyle: .alert)
        alertController.view.tintColor = UIColor.black
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        let goAction = UIAlertAction(title: "Go to LoopGolf.com", style: .default) { (action) in
            
            UIApplication.shared.openURL(URL(string: "http://www.loopgolf.com/coming-soon/")!)
        }
        alertController.addAction(goAction)
        self.present(alertController, animated: true) {
            alertController.view.tintColor = UIColor.black
        }

    }
    
    
}
