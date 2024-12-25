//
//  RideType.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 25/12/2024.
//

import Foundation
enum RideType:  Int ,CaseIterable, Identifiable {
    var id: Int {return rawValue}
    
    case uberX
    case uberBlack
    case uberXL
    
    var name: String {
        switch self {
        case .uberX: return "UberX"
        case .uberBlack: return "UberBlack"
        case .uberXL: return "UberXL"
        }
    }
    
    var rate: Double {
        switch self {
        case .uberX: return 1.5
        case .uberBlack: return 3.0
        case .uberXL: return 2.5
        }
    }
}
