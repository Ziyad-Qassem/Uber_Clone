//
//  LocationSearchView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import SwiftUI

struct LocationSearchView: View {
    @Binding var mapState : MapViewState
    @EnvironmentObject  var viewModel : LocationSearchViewModel
    @State private var startRideLocationText: String = ""
    var body: some View {
        VStack {
            // search text fields
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack{
                    TextField("CurrentLocation" , text: $startRideLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?" , text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }.padding(.horizontal)
                .padding(.top , 64)
            
            Divider()
                .padding(.vertical)
            
            // search results
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewModel.searchResults , id:\.self) { result in 
                        SearchResultCell(locationName: result.title, locationInformation: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.selectLocation(result)
                                    mapState = .locationSelected
                                }
                            }
                    }
                }
                
            }
      
        }
        .background(Color.theme.backgroundColor)
    }
}

#Preview {
    LocationSearchView(mapState: .constant(.searchingForLocation))
}
