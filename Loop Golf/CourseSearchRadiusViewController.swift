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
import CoreLocation

class CourseSearchRadiusViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    var initialLocation = CLLocation()
    let regionRadius: CLLocationDistance = 5000000
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Course Search Radius"
        navigationController!.navigationBar.tintColor = UIColor.blackColor()
        
        centerMapOnLocation(initialLocation)
    }
}

extension CourseSearchRadiusViewController: MKMapViewDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        var userLat = location.coordinate.latitude
        print(userLat)
        var userLon = location.coordinate.longitude
        print(userLon)
        initialLocation = CLLocation(latitude: userLat, longitude: userLon)
        self.locationManager.stopUpdatingLocation()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

