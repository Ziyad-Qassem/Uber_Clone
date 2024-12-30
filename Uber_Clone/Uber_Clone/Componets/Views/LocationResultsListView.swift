//
//  LocationListView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 29/12/2024.
//

import SwiftUI

struct LocationResultsListView: View {
    @StateObject var locationManager : LocationSearchViewModel
    let cofig : LocationResultViewConfig
    var body: some View {
        ScrollView{
               VStack(alignment: .leading){
                   ForEach(locationManager.searchResults , id:\.self) { result in
                       SearchResultCell(locationName: result.title, locationInformation: result.subtitle)
                           .onTapGesture {
                               withAnimation(.spring()) {
                                   locationManager.selectLocation(result, config: cofig)
                               }
                           }
                   }
               }
               
           }
    }
}
#Preview {
    LocationResultsListView(locationManager: LocationSearchViewModel(), cofig: .saveLocation(.home))
}
