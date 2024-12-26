//
//  HomeView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var authManager : AuthenticationManager
    var body: some View {
        Group {
            if authManager.userSession == nil {
                LoginView()
            }else {
                ZStack(alignment: .bottom) {
                    ZStack(alignment: .top){
                        UberMapViewRepresentable(mapState: $mapState)
                            .ignoresSafeArea()
                        
                        if mapState == .searchingForLocation  {
                            LocationSearchView(mapState: $mapState)
                        }else if mapState == .noInput{
                            LocationSearchActivationView()
                                .padding(.top , 70)
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        mapState = .searchingForLocation
                                    }
                                    
                                }
                        }
                        
                        MapViewActionButton(mapState: $mapState)
                            .padding(.leading)
                            .padding(.top , 4)
                        
                    }
                    
                    if mapState == .locationSelected || mapState == .polylineCreated{
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    }
                }.edgesIgnoringSafeArea(.bottom)
                    .onReceive(LocationManager.shared.$userLocation) { location in
                        if let location  = location {
                            locationViewModel.userLocation = location
                        }
                    }
            }
            
        }
    }
}

#Preview {
    HomeView()
}
