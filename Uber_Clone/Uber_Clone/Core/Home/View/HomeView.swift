//
//  HomeView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationManager: LocationSearchViewModel
    @EnvironmentObject var authManager : AuthenticationManager
    @State private var showSideMenu : Bool = false
    var body: some View {
        Group {
            if authManager.userSession == nil {
                LoginView()
            }else if let user = authManager.currentUser {
                NavigationStack {
                    ZStack {
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        
                        mapView
                            .offset(x: showSideMenu ? 300 : 0)
                            .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                    }.onAppear {
                        showSideMenu = false
                    }
                }
            }
            
        }
    }
}

extension HomeView {
    var mapView : some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top){
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation  {
                    LocationSearchView()
                }else if mapState == .noInput{
                    LocationSearchActivationView()
                        .padding(.top , 70)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchingForLocation
                            }
                            
                        }
                }
                
                MapViewActionButton(mapState: $mapState, showSideMenu: $showSideMenu)
                    .padding(.leading)
                    .padding(.top , 4)
                
            }
            
            if mapState == .locationSelected || mapState == .polylineCreated{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }                    .edgesIgnoringSafeArea(.bottom)
            .onReceive(LocationManager.shared.$userLocation) { location in
                if let location  = location {
                    locationManager.userLocation = location
                }
            }
            .onReceive(locationManager.$seletedLocation) { location  in
                if location != nil {
                    self.mapState = .locationSelected
                }
            }

    }
}

#Preview {
    HomeView()
        .environmentObject(AuthenticationManager())
       
}
