//
//  HomeView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UberMapViewRepresentable()
            .ignoresSafeArea()
    }
}

#Preview {
    HomeView()
}
