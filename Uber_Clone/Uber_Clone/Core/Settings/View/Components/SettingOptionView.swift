//
//  SettingOptionView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 29/12/2024.
//

import SwiftUI

struct SettingOptionView: View {
    var  option = SettingsOptions.notifications
    
    let tintColor : Color
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: option.imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(tintColor)
            
            Text(option.title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.theme.primaryTextColor)
        }
        .padding(4)
    }
}

#Preview {
    SettingOptionView(option: .notifications, tintColor: Color(.systemBlue))
}
