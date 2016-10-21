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
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        userCoordinateLocation = appDelegate.userCoordinateLocation
        adjustMapRegionRadius(previouslySavedRadius)
        centerMapOnLocation(userCoordinateLocation, regionRadius: regionRadiusToSetMap)
        addRadiusCircle(userCoordinateLocation, savedRadius: (previouslySavedRadius * 1609.34))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search Radius"
        navigationController!.navigationBar.tintColor = UIColor.blackColor()
        
        topViewBackground.layer.shadowColor = UIColor.blackColor().CGColor
        topViewBackground.layer.shadowOpacity = 0.5
        topViewBackground.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        bottomViewBackground.layer.shadowColor = UIColor.blackColor().CGColor
        bottomViewBackground.layer.shadowOpacity = 0.5
        bottomViewBackground.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        
        sliderValuePopupView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        sliderValuePopupView.alpha = 0
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: ("saveChanges"))
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 17)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.rightBarButtonItem?.enabled = false
    }
}

extension CourseSearchRadiusViewController: MKMapViewDelegate {
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseOut, animations: {
            self.sliderValuePopupView.alpha = 1
        }, completion: nil)
        
        var increment: Float = 1
        var newValue: Float = sender.value / increment
        sender.value = floor(newValue) * increment
        var formatted: String {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            formatter.minimumFractionDigits = 0
            return formatter.stringFromNumber(sender.value) ?? ""
        }
        currentSliderValue = Double(sender.value)
        sliderDisplayValue = formatted
        
        adjustCircleSize(userCoordinateLocation, newRadius: (currentSliderValue * 1609.34))
        
        adjustMapRegionRadius(currentSliderValue)
        centerMapOnLocation(userCoordinateLocation, regionRadius: regionRadiusToSetMap)
        sliderValuePopupLabel.text = "\(sliderDisplayValue) mi"
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    @IBAction func sliderTouchUpInside(sender: UISlider) {
        sliderEditingEnded()
    }
    
    @IBAction func sliderTouchUpOutside(sender: UISlider) {
        sliderEditingEnded()
    }
    
    func sliderEditingEnded() {
        UIView.animateWithDuration(0.2, delay: 0.4, options: .CurveEaseOut, animations: {
            self.sliderValuePopupView.alpha = 0
            }, completion: nil)
    }
    
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addRadiusCircle(location: CLLocation, savedRadius: Double) {
        self.mapView.delegate = self
        circle = MKCircle(centerCoordinate: location.coordinate, radius: savedRadius as CLLocationDistance)
        self.mapView.addOverlay(circle)
    }
    
    func adjustCircleSize(location: CLLocation, newRadius: Double) {
        self.mapView.delegate = self
        self.mapView.removeOverlay(circle)
        circle = MKCircle(centerCoordinate: location.coordinate, radius: newRadius as CLLocationDistance)
        self.mapView.addOverlay(circle)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            var circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.strokeColor = UIColor.blackColor()
            circleRenderer.fillColor = UIColor.blackColor().colorWithAlphaComponent(0.1)
            circleRenderer.lineWidth = 2
            return circleRenderer
        } else {
            return MKPolylineRenderer()
        }
    }
    
    func adjustMapRegionRadius(regionRadius: Double) -> Double {
        
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
        navigationController?.popViewControllerAnimated(true)
    }
}

