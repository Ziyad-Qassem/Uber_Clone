//
//  SideMenuView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 27/12/2024.
//

import SwiftUI

struct SideMenuView: View {
    private let user : UserModel
    init(user : UserModel){
        self.user = user
    }
    private let screenWidth : CGFloat = UIScreen.main.bounds.width
    var body: some View {
    
            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 35){
                    UserInfoView(user: user, showButton: false)
                    
                    VStack(alignment: .leading ,spacing: 16){
                        Text("Do more with your account")
                            .font(.footnote)
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .fontWeight(.semibold)
                        
                        HStack{
                            Image(systemName: "dollarsign.square")
                                .font(.title)
                                .imageScale(.medium)
                            
                            Text("Make Money Driving")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(6)
                        }
                        Rectangle()
                            .frame(width: screenWidth - 100, height: 0.75)
                            .foregroundStyle(Color(.separator))
                            .padding(.vertical)
                            .opacity(0.7)
                        
                    }
                }
                
                VStack(alignment : .leading,spacing: 35 ){
                    ForEach(SideMenuOption.allCases) {option in
                        NavigationLink(value: option) {
                            OptionView(optionCase: option).padding()
                        }
                    }
                    Spacer()
                }.navigationDestination(for: SideMenuOption.self) { option in
                    switch option {
                    case .trips:
                        Text("TRIPS")
                    case .wallet:
                        Text("WALLET")
                    case .settings:
                        SettingsView(user: user)
                    case .messages:
                        Text("MESSAGES")
                    }
                }
                
            }.padding(.horizontal)
                .padding(.top, 32)
        
    }
}

#Preview {
    NavigationStack{ SideMenuView(user: MockData.userMockData)}
}
