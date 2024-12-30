//
//  UserInfoView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 27/12/2024.
//

import SwiftUI

struct UserInfoView: View {
     let user : UserModel?
    var showButton : Bool = true
   
    var body: some View {
        HStack{
            Image("profile-photo")
                .resizable()
                .clipShape(.circle)
                .scaledToFill()
                .frame(width: 64, height: 64)
            
            VStack(alignment : .leading, spacing : 8) {
                Text(user?.fullName ?? "userName")
                    .font(.system(size: 16, weight: .semibold))
                 
                Text(user?.email ?? "example@gmail.com")
                    .accentColor(.black)
                    .opacity(0.8)
                    .font(.footnote)
            }
               
            
            Spacer()
            
            if showButton {
                Image(systemName: "chevron.right")
                    .imageScale(.small)
                    .font(.title)
                
            }
            
        }.foregroundStyle(Color.theme.primaryTextColor)
    
    }
}

#Preview {
    UserInfoView(user: MockData.userMockData)
}
