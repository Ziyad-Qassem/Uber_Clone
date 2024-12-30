//
//  SavedLocation.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 29/12/2024.
//

import Foundation
import Firebase
struct SavedLocation : Codable {
    let title : String
    let address : String
    let coordinate : GeoPoint
}
