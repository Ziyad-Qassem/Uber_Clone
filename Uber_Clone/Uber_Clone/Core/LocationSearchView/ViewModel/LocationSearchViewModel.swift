//
//  LocationSearchViewModel.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import Foundation
import MapKit
class LocationSearchViewModel : NSObject, ObservableObject{
    
    @Published var searchResults = [MKLocalSearchCompletion]()
    @Published var seletedLocationCoordinates: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
  var queryFragment : String = "" {
        didSet{
            searchCompleter.queryFragment = queryFragment
        }
  }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    func selectLocation(_ location : MKLocalSearchCompletion) {
        searchForLocationMapDAta(forLocalSearchCompletion: location) { response, error in
            if let error = error {
                #if DEBUG
               print("DEBUG: Error searching for location in selectLocation in LocationSearchViewModel: \(error.localizedDescription)")
                #endif
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.seletedLocationCoordinates = coordinate
        }
    }
    
    func searchForLocationMapDAta(forLocalSearchCompletion  localSearch: MKLocalSearchCompletion , completion: @escaping MKLocalSearch.CompletionHandler) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
        
    }
    
}
//MARK: confirming MKLocalSearchCompleter delegate functions
extension LocationSearchViewModel : MKLocalSearchCompleterDelegate  {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
    }
    
}
