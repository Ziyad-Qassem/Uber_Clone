//
//  UberMapViewRepresentable.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//


import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    @Binding var mapState : MapViewState
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("DEBUG: map state is \(mapState)")
        
        switch mapState {
        case .noInput:
            context.coordinator.cleareMapViewAndRecenterOnUserLocation()
            break
        case .locationSelected:
            if let selectedLocationCoordinate = locationViewModel.seletedLocationCoordinates {
                context.coordinator.addAndSelectAnnotation(withCoordinate: selectedLocationCoordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: selectedLocationCoordinate)
            }
            break
        case .searchingForLocation:
          
            break
        }
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
        var userLocationCoordinate : CLLocationCoordinate2D?
        var currentMapRegion: MKCoordinateRegion?
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            // Get user location coordinates
            self.userLocationCoordinate = userLocation.coordinate
            let lat = userLocation.coordinate.latitude
            let long = userLocation.coordinate.longitude
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: lat, longitude: long),
                span: span
            )
            self.currentMapRegion = region
            // Only update the region if it has changed significantly (to avoid zooming in and out continuously)
            if lastRegion == nil || shouldUpdateRegion(region) {
                parent.mapView.setRegion(region, animated: true)
                lastRegion = region
            }
            
        }
        // to render the line between destination on the map
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                        let renderer = MKPolylineRenderer(polyline: polyline)
                        renderer.strokeColor = .systemBlue
                        renderer.lineWidth = 5.0
                        return renderer
                    }
                    
                    // Default to returning an empty renderer if the overlay type isn't handled
                    return MKOverlayRenderer(overlay: overlay)
        }
        
        // Check if the region has changed significantly
        func shouldUpdateRegion(_ newRegion: MKCoordinateRegion) -> Bool {
            guard let lastRegion = lastRegion else { return true }
            
            let deltaLat = abs(lastRegion.center.latitude - newRegion.center.latitude)
            let deltaLong = abs(lastRegion.center.longitude - newRegion.center.longitude)
            
            // Only update if the location has changed significantly (e.g., more than 100 meters)
            return deltaLat > 0.001 || deltaLong > 0.001
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate : CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            
        }
        
        func configurePolyline(withDestinationCoordinate coordinate : CLLocationCoordinate2D){
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                    self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
            
        }
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D ,to destination: CLLocationCoordinate2D , completion: @escaping (MKRoute) -> Void){
            
            let userPlaceMark = MKPlacemark(coordinate: userLocation)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlaceMark)
            
            let destinationPlaceMark = MKPlacemark(coordinate: destination)
            request.destination = MKMapItem(placemark: destinationPlaceMark)
            
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                if let error = error {
                    print("failed to get directions  in getDestinationRoute in MapCoordinator \(error.localizedDescription)")
                        return
                }
                guard let route = response?.routes.first else {return}
                completion(route)
            }
        }
        
        
        func cleareMapViewAndRecenterOnUserLocation(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            if let currentRegion = currentMapRegion{
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
        
    }
}
