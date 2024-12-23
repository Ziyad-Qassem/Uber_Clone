//
//  LocationManager.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import CoreLocation

class LocationManager : NSObject ,  ObservableObject {
    private let locationManager =  CLLocationManager()
    override init() {
        super.init( )
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
//MARK: clllocation manager delegate functions
extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty  else { return }
        
        locationManager.startUpdatingLocation()
    }
}
