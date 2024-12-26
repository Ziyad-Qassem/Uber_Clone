//
//  Color.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 26/12/2024.
//

import Foundation
import SwiftUICore

extension Color{
    static let theme = ColorTheme()
}

struct ColorTheme{
    let backgroundColor =  Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let chevronSignColor = Color("chevron-sign-to-right")
    let primaryTextColor = Color("PrimaryTextColor")
}

