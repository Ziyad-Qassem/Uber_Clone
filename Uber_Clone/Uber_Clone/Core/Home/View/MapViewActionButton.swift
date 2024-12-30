//
//  MapViewActionButton.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import SwiftUI

struct MapViewActionButton: View {
    @EnvironmentObject var  locationViewModel : LocationSearchViewModel
    @Binding var mapState: MapViewState
    @Binding var showSideMenu: Bool
    var body: some View {
        Button {
            // go to searchView
            withAnimation(.spring()){
                actionForState(mapState)
            }
            
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(Color.black)
                .padding()
                .background(.white)
                .clipShape(.circle)
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity , alignment: .leading)
        
    }
    func actionForState(_ state : MapViewState) {
        switch state {
            case .noInput:
            showSideMenu.toggle()
            break
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected , .polylineCreated:
            mapState = .noInput
            locationViewModel.seletedLocation = nil 
        }
    }
    func imageNameForState(_ state : MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation , .locationSelected , .polylineCreated:
            return "arrow.left"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput), showSideMenu: .constant(false))
}
