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
    
    var baseFare : Double {
        switch self {
        case .uberX:    return 5
        case .uberBlack: return 20
        case .uberXL: return 10
        }
    }
    
    func computeRidePrice(for distanceInMeters : Double) -> Double {
        let distanceInKiloMeters = distanceInMeters / 1000
        switch self {
        case .uberX: return distanceInKiloMeters * rate + baseFare
        case .uberBlack: return distanceInKiloMeters * rate + baseFare
        case .uberXL: return distanceInKiloMeters * rate + baseFare
        }
    }
    
    
}
