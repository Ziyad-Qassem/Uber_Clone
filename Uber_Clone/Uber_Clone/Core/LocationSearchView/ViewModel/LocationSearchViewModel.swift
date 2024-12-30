//
//  LocationSearchViewModel.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import Foundation
import MapKit
import Firebase
enum LocationResultViewConfig {
    case ride
    case saveLocation(SavedLocationOption)
}

class LocationSearchViewModel : NSObject, ObservableObject{
    
    @Published var searchResults = [MKLocalSearchCompletion]()
    @Published var seletedLocation: LocationModel?
    @Published var pickupTime : String?
    @Published var dropOffTime : String?
    private let searchCompleter = MKLocalSearchCompleter()
    
    var queryFragment : String = "" {
        didSet{
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation : CLLocationCoordinate2D?
    
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    func selectLocation(_ searchedLocation : MKLocalSearchCompletion, config: LocationResultViewConfig) {
        searchForLocationMapData(forLocalSearchCompletion: searchedLocation) { response, error in
            if let error = error {
                print("DEBUG: Error searching for location in selectLocation in LocationSearchViewModel: \(error.localizedDescription)")
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            switch config {
            case .ride:
                self.seletedLocation = LocationModel(title: searchedLocation.title, coordinate: coordinate)
            case .saveLocation(let locationType):
                print("DEBUG: saved location coordinate \(coordinate) ")
                
                let savedLocation = SavedLocation(title: searchedLocation.title, address: searchedLocation.subtitle, coordinate: GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude))
               
                DatabaseManager.shared.updateUserSavedLocations(with: savedLocation , locationType : locationType )
            }
        }
        
        
    }
       
      
    
    // to use searching for location in map
    func searchForLocationMapData(forLocalSearchCompletion  localSearch: MKLocalSearchCompletion , completion: @escaping MKLocalSearch.CompletionHandler) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
        
    }
   
    // calculate distance between user location and his destination
    func computeRidePrice(fortype type : RideType) -> Double {
        guard let destinatioinCoordinate = seletedLocation?.coordinate else { return 0 }
        
        guard let userLocation = self.userLocation else {return 0}
        
        let userlocation  = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        let destinationLocation = CLLocation(latitude: destinatioinCoordinate.latitude , longitude: destinatioinCoordinate.longitude)
        
        let distance = userlocation.distance(from: destinationLocation)
        
        return type.computeRidePrice(for: distance)
    }
    
    func configurePickupandDropOffTime(with estimatedTravelTime : Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        
        pickupTime = formatter.string(from: Date())
        
        dropOffTime = formatter.string(from: Date() + estimatedTravelTime)
    }
  
}
//MARK: confirming MKLocalSearchCompleter delegate functions
extension LocationSearchViewModel : MKLocalSearchCompleterDelegate  {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
    }
    
}
