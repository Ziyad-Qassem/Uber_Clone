//
//  SideMenuOption.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 28/12/2024.
//

import Foundation
enum SideMenuOption : Int ,CaseIterable , Identifiable  {
    var id: Int {
        return self.rawValue
    }
    
    case trips
    case wallet
    case settings
    case messages
    
    var title : String {
        switch self {
            
        case .trips:
            return "Your Trips"
        case .wallet:
            return "Wallet"
        case .settings:
            return "Settings"
        case .messages:
            return "Messages"
        }
    }
    
    var imageName : String {
        switch self {
        case .trips:
            return "list.bullet.rectangle"
        case .wallet:
            return "creditcard"
        case .settings:
            return "gear"
        case .messages:
            return "bubble.left"
        }
    }
}
