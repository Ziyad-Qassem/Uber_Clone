//
//  SearchResultCell.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import SwiftUI

struct SearchResultCell: View {
    let locationName : String
    let locationInformation : String
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundStyle(.blue)
                .accentColor(.white)
                .frame(width: 40 , height: 40)
            VStack(alignment: .leading, spacing: 4) {
                Text(locationName)
                    .font(.body)
                
                Text(locationInformation)
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                
                Divider()
            }.padding(.leading , 8)
                .padding(.vertical , 8)
            
        }.padding(.leading)
    }
}

#Preview {
    SearchResultCell(locationName: "123", locationInformation: "just testing")
}
