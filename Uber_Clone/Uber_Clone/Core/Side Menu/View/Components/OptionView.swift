//
//  OptionView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 28/12/2024.
//

import SwiftUI

struct OptionView: View {
    var optionCase = SideMenuOption.trips
   
    var body: some View {
        HStack(spacing : 16 ){
            Image(systemName: optionCase.imageName)
                .imageScale(.medium)
                .font(.title)
            
            VStack(alignment: .leading){
                Text(optionCase.title)
                    .font(.system(size: 16, weight: .semibold))
                
            }
            Spacer()
        }.foregroundStyle(Color.theme.primaryTextColor)
    }
}

#Preview {
    OptionView()
}
