//
//  HomeTabViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/2/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class HomeTabViewController: UIViewController {

    @IBOutlet weak var newReservationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "LandingPageBackgroundImage")
        self.view.insertSubview(backgroundImage, at: 0)
        
        newReservationButton.layer.backgroundColor = UIColor.black.withAlphaComponent(0.75).cgColor
        newReservationButton.layer.cornerRadius = 8
        newReservationButton.layer.borderColor = UIColor.white.cgColor
        newReservationButton.layer.borderWidth = 1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension HomeTabViewController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func newReservationButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "newReservationFromHomeTabSegue", sender: self)
    }
    
}

