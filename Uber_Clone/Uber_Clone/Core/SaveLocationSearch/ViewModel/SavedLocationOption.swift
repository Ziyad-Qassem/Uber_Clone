//
//  SavedLocationOption.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 29/12/2024.
//

import Foundation
enum SavedLocationOption : Int ,CaseIterable , Identifiable  {
    var id: Int {
        return self.rawValue
    }
    
    case home
    case work
    
    var title : String {
        switch self {
        case .home:
            return "Home"
        case .work:
            return "Work"
      
        }
    }
    var subtitle : String {
        switch self {
        case .home:
            return "Add Home"
        case .work:
            return "Add Work"
        }
    }

    var imageName : String {
        switch self {
        case .home:
            return "house.circle.fill"
        case .work:
            return "archivebox.circle.fill"
        }
    }
    
    var databasekey : String {
        switch self {
            
        case .home:
            return "homeLocation"
        case .work:
            return "workLocation"
        }
    }
    
    func subtitle (for user : UserModel) -> String {
        switch self {
        case .home:
            if let homeLocation = user.homeLocation {
                return homeLocation.title
            }else {
                return "Add Home Adress"
            }
        case .work:
            if let workLocation = user.workLocation {
                return workLocation.title
            }else {
                return "Add Work Address"
            }
        }
    }
}

