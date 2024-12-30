//
//  SettingsView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 29/12/2024.
//

import SwiftUI

struct SettingsView: View {
    private let user : UserModel
    @EnvironmentObject var authManager : AuthenticationManager

    init(user: UserModel) {
        self.user = user
    }
    var body: some View {
        VStack {
            List {
                Section {
                    UserInfoView(user: user, showButton: true).padding(8)
                }
                Section("FAVOURITES") {
                    ForEach (SavedLocationOption.allCases){ option in
                        
                        NavigationLink {
                            SaveLocationsSearchView(config: option)
                        } label: {
                            
                            SavedLocationOptionView(user: user, option: option)
                        }

                        
                    }
                }
                
                Section("SETTINGS") {
                    SettingOptionView(option: .notifications ,tintColor: Color(.systemPurple))
                    
                    SettingOptionView(option: .payment ,tintColor: Color(.systemPurple))
                }
                
                Section("Account") {
                    SettingOptionView(option: .money ,tintColor: Color(.systemPurple))
                    
                    SettingOptionView(option: .signOut ,tintColor: Color(.systemPurple))
                        .onTapGesture {
                            authManager.signoutUser()
                        }
                }
            }
        }.navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
    }
    
  
}

#Preview {
    NavigationStack{
        SettingsView(user: MockData.userMockData)
    }
}
