//
//  SettingsOptions.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 29/12/2024.
//

import Foundation

enum SettingsOptions : Int ,CaseIterable , Identifiable  {
    var id: Int {
        return self.rawValue
    }
    
    case notifications
    case payment
    case money
    case signOut
    
    var title : String {
        switch self {
        case .notifications:
            return "Notifications"
        case .payment:
            return "Payment Methods"
        case .money:
            return "Make money driving "
        case .signOut:
            return "Sign Out"
        }
    }

    var imageName : String {
        switch self {
          
        case .payment:
            return "creditcard.circle.fill"
        case .money:
            return "dollarsign.circle.fill"
        case .signOut:
            return "arrow.left.circle.fill"
        case .notifications:
            return "bell.circle.fill"
        }
    }
}
