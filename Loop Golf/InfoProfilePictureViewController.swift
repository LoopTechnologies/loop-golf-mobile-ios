//
//  InfoProfilePictureViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/26/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit

class InfoProfilePictureViewController: UIViewController {
    
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        popoverView.layer.cornerRadius = 8
        
    }
}

extension InfoProfilePictureViewController {
    
    @IBAction func dismissVCButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {})
    }
    
    @IBAction func backgroundButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {})
    } 
}
