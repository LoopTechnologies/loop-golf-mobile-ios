//
//  AppDelegate.swift
//  Loop Golf
//
//  Created by Matt Hills on 10/2/16.
//  Copyright © 2016 Loop Sports Technologies LLC. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    var locationManager = CLLocationManager()
    var userCoordinateLocation = CLLocation()
    var locationServicesEnabled: Bool?
    var notificationsEnabled: Bool?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = UIColor.white
        let tabBarAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Regular", size: 11)!]
        UITabBarItem.appearance().setTitleTextAttributes(tabBarAttributes, for: UIControlState())
                
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        registerForPushNotifications(application)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        locationManager.startUpdatingLocation()
        registerForPushNotifications(application)
        
        
        if (CLLocationManager.locationServicesEnabled()) {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                locationServicesEnabled = false
            case .authorizedAlways, .authorizedWhenInUse:
                locationServicesEnabled = true
            }
        } else {
            locationServicesEnabled = false
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            userCoordinateLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.locationManager.stopUpdatingLocation()
        }
     }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error didFail: " + error.localizedDescription)
    }
    
    
    
    
    func registerForPushNotifications(_ application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(types: [.badge, .alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
    }
    
    
    
    
    @objc(application:didRegisterUserNotificationSettings:)
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
        if (notificationSettings.types != UIUserNotificationType()) {
            notificationsEnabled = true
            //application.registerForRemoteNotifications()
        } else {
            notificationsEnabled = false
        }
    }
}

