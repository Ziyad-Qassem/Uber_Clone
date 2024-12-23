//
//  HomeView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var showSearchView : Bool = false
    var body: some View {
        ZStack(alignment: .top){
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            if showSearchView  {
                LocationSearchView()
            }else{
                LocationSearchActivationView()
                    .padding(.top , 70)
                    .onTapGesture {
                        withAnimation(.spring()){
                            showSearchView.toggle()
                        }
                        
                    }
            }
            
            MapViewActionButton(showSearchView: $showSearchView)
                .padding(.leading)
                .padding(.top , 4)
                
        }
    }
}

#Preview {
    HomeView()
}
