//
//  MapViewActionButton.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var showSearchView: Bool
    var body: some View {
        Button {
            // go to searchView
            withAnimation(.spring()){
                showSearchView.toggle()
            }
            
        } label: {
            Image(systemName: showSearchView ? "arrow.left" : "line.3.horizontal")
                .font(.title2)
                .foregroundColor(Color.black)
                .padding()
                .background(.white)
                .clipShape(.circle)
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity , alignment: .leading)

    }
}

#Preview {
    MapViewActionButton(showSearchView: .constant(false))
}
