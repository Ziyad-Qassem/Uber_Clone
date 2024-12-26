//
//  Uber_CloneApp.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 23/12/2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct Uber_CloneApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()
    @StateObject var authenticationManager = AuthenticationManager()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            
            HomeView()
                .environmentObject(locationViewModel)
                .environmentObject(authenticationManager)
                
        }
    }
}
