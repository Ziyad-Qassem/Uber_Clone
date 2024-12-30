//
//  SaveLocationsSearchView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 29/12/2024.
//

import SwiftUI

struct SaveLocationsSearchView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject  var locationManager = LocationSearchViewModel()
    let config : SavedLocationOption
    var body: some View {
        VStack {
            TextField("search for a location", text: $locationManager.queryFragment)
                .frame(height: 32)
                .padding(.leading)
                .background(Color(.systemGray5))
                .padding()
            
            Spacer()
            
            LocationResultsListView(locationManager: locationManager, cofig: .saveLocation(config))
            
            
        }.navigationTitle(config.subtitle)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SaveLocationsSearchView(config: .home)
    }
}
