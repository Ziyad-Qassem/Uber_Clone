//
//  UberMapViewRepresentable.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import Foundation
import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager()

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}
//MARK: map coordinator
extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable
        var lastRegion: MKCoordinateRegion?

        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            // Get user location coordinates
            let lat = userLocation.coordinate.latitude
            let long = userLocation.coordinate.longitude
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: lat, longitude: long),
                span: span
            )
            
            // Only update the region if it has changed significantly (to avoid zooming in and out continuously)
            if lastRegion == nil || shouldUpdateRegion(region) {
                parent.mapView.setRegion(region, animated: true)
                lastRegion = region
            }
        }
        
        // Check if the region has changed significantly
        func shouldUpdateRegion(_ newRegion: MKCoordinateRegion) -> Bool {
            guard let lastRegion = lastRegion else { return true }
            
            let deltaLat = abs(lastRegion.center.latitude - newRegion.center.latitude)
            let deltaLong = abs(lastRegion.center.longitude - newRegion.center.longitude)
            
            // Only update if the location has changed significantly (e.g., more than 100 meters)
            return deltaLat > 0.001 || deltaLong > 0.001
        }
    }
}
