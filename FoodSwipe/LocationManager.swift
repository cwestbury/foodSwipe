//
//  LocationManager.swift
//  FoodSwipe
//
//  Created by Cameron Westbury on 1/25/17.
//  Copyright © 2017 Cameron Westbury. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    static let sharedInstance = LocationManager()
    
    var locationManager: CLLocationManager = CLLocationManager()
    var userLocationCoordinates = CLLocationCoordinate2D()
    
    var searchedCityName = "" as String
    let geocoder = CLGeocoder()

    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        userLocationCoordinates = CLLocationCoordinate2D(latitude: locations.last!.coordinate.latitude, longitude:locations.last!.coordinate.longitude)
        self.locationManager.stopUpdatingLocation()
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                print(pm.locality!)
                self.searchedCityName = pm.locality!
                
                DispatchQueue.main.async{
                    NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "recievedLocationFromUser"), object: nil))
                }
                
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Loc Manager Error \(error)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Got new auth status \(status.rawValue)")
        setUpLocationMonitoring()
    }
    
    func convertCoordinateToString(_ coordinate: CLLocationCoordinate2D) -> String {
        print("Coordinate to String: \(coordinate.latitude),\(coordinate.longitude)")
        return "\(coordinate.latitude),\(coordinate.longitude)"
    }
    
    @available(iOS 9.0, *)
    func setUpLocationMonitoring() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                print("have access to loc")
                locationManager.requestLocation()
            case .denied, .restricted:
                print("Location services disabled/restricted")
            case .notDetermined:
                if (locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization))) {
                    print("requesting loc auth")
                    locationManager.requestWhenInUseAuthorization()
                }
            }
        } else {
            print("Turn on location services in Settings!")
        }
        
    }

}
