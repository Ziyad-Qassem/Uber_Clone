//
//  SavedLocationOptionView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 29/12/2024.
//

import SwiftUI

struct SavedLocationOptionView: View {
     let user : UserModel
    var option = SavedLocationOption.home
    private var dynamicSubtitle: String {
           option.subtitle(for: user)
       }
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: option.imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(Color(.systemBlue))
            VStack(alignment: .leading, spacing: 5){
                
                Text(option.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Text(dynamicSubtitle)
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            
        }
    }
}

#Preview {
    SavedLocationOptionView(user: MockData.userMockData)
}
