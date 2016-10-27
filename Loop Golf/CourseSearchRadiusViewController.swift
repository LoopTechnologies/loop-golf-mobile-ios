//
//  CourseSearchRadiusViewController.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/19/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class CourseSearchRadiusViewController: UIViewController {
    
    //----------- DUMMY VARIABLES - SIMULATE INTERACTION WITH DATABASE ----------------//
    var previouslySavedRadius: Double = 25.0
    // --------------------------------------------------------------------------------//
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var topViewBackground: UIView!
    @IBOutlet weak var bottomViewBackground: UIView!
    @IBOutlet weak var sliderValuePopupView: UIView!
    @IBOutlet weak var sliderValuePopupLabel: UILabel!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var circle = MKCircle()
    var userCoordinateLocation = CLLocation()
    var regionRadiusToSetMap = CLLocationDistance()
    let mile5RegionRadius: CLLocationDistance = 19312.1 // 12 mile E-W and N-S map size in meters
    let mile10RegionRadius: CLLocationDistance = 38624.3 // 24 mile E-W and N-S map size in meters
    let mile20RegionRadius: CLLocationDistance = 67592.4 // 42 mile E-W and N-S map size in meters
    let mile40RegionRadius: CLLocationDistance = 131966.1 // 82 mile E-W and N-S map size in meters
    let mile75RegionRadius: CLLocationDistance = 244620.1 // 152 mile E-W and N-S map size in meters
    let mile100RegionRadius: CLLocationDistance = 337962.1 // 210 mile E-W and N-S map size in meters
    
    let regionRadius: CLLocationDistance = 177028 // 110 mile E-W and N-S map size in meters
    let smallRegionRadius: CLLocationDistance = 38624.3 // 24 mile E-W and N-S map size in meters
    var currentSliderValue = Double()
    var sliderDisplayValue = String()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userCoordinateLocation = appDelegate.userCoordinateLocation
        adjustMapRegionRadius(previouslySavedRadius)
        centerMapOnLocation(userCoordinateLocation, regionRadius: regionRadiusToSetMap)
        addRadiusCircle(userCoordinateLocation, savedRadius: (previouslySavedRadius * 1609.34))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search Radius"
        navigationController!.navigationBar.tintColor = UIColor.black
        
        topViewBackground.layer.shadowColor = UIColor.black.cgColor
        topViewBackground.layer.shadowOpacity = 0.5
        topViewBackground.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        bottomViewBackground.layer.shadowColor = UIColor.black.cgColor
        bottomViewBackground.layer.shadowOpacity = 0.5
        bottomViewBackground.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        sliderValuePopupView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        sliderValuePopupView.alpha = 0
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: (#selector(CourseSearchRadiusViewController.saveChanges)))
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], for: UIControlState())
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

extension CourseSearchRadiusViewController: MKMapViewDelegate {
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.sliderValuePopupView.alpha = 1
        }, completion: nil)
        
        var increment: Float = 1
        var newValue: Float = sender.value / increment
        sender.value = floor(newValue) * increment
        var formatted: String {
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.decimal
            formatter.minimumFractionDigits = 0
            return formatter.string(from: NSNumber(value: sender.value)) ?? ""
        }
        currentSliderValue = Double(sender.value)
        sliderDisplayValue = formatted
        
        adjustCircleSize(userCoordinateLocation, newRadius: (currentSliderValue * 1609.34))
        
        adjustMapRegionRadius(currentSliderValue)
        centerMapOnLocation(userCoordinateLocation, regionRadius: regionRadiusToSetMap)
        sliderValuePopupLabel.text = "\(sliderDisplayValue) mi"
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    @IBAction func sliderTouchUpInside(_ sender: UISlider) {
        sliderEditingEnded()
    }
    
    @IBAction func sliderTouchUpOutside(_ sender: UISlider) {
        sliderEditingEnded()
    }
    
    func sliderEditingEnded() {
        UIView.animate(withDuration: 0.2, delay: 0.4, options: .curveEaseOut, animations: {
            self.sliderValuePopupView.alpha = 0
            }, completion: nil)
    }
    
    func centerMapOnLocation(_ location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addRadiusCircle(_ location: CLLocation, savedRadius: Double) {
        self.mapView.delegate = self
        circle = MKCircle(center: location.coordinate, radius: savedRadius as CLLocationDistance)
        self.mapView.add(circle)
    }
    
    func adjustCircleSize(_ location: CLLocation, newRadius: Double) {
        self.mapView.delegate = self
        self.mapView.remove(circle)
        circle = MKCircle(center: location.coordinate, radius: newRadius as CLLocationDistance)
        self.mapView.add(circle)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.strokeColor = UIColor.black
            circleRenderer.fillColor = UIColor.black.withAlphaComponent(0.1)
            circleRenderer.lineWidth = 2
            return circleRenderer
        } else {
            return MKPolylineRenderer()
        }
    }
    
    func adjustMapRegionRadius(_ regionRadius: Double) -> Double {
        
        if (regionRadius <= 5) {
            regionRadiusToSetMap = mile5RegionRadius
        } else if (regionRadius > 5 && regionRadius <= 10) {
            regionRadiusToSetMap = mile10RegionRadius
        }  else if (regionRadius > 10 && regionRadius <= 20) {
            regionRadiusToSetMap = mile20RegionRadius
        }  else if (regionRadius > 20 && regionRadius <= 40) {
            regionRadiusToSetMap = mile40RegionRadius
        } else if (regionRadius > 40 && regionRadius <= 75) {
            regionRadiusToSetMap = mile75RegionRadius
        } else if (regionRadius > 75 && regionRadius <= 100) {
            regionRadiusToSetMap = mile100RegionRadius
        }
    
        return regionRadiusToSetMap
    }
    
    func saveChanges() {
        // Save currentSliderValue.
        print("radius to save: \(currentSliderValue)")
        navigationController?.popViewController(animated: true)
    }
}

