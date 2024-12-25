//
//  RideOptionView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 25/12/2024.
//

import SwiftUI

struct RideOptionView: View {
    private var rideType = RideType.uberX
    private var rideBasePrice : Double?
    init(rideType : RideType , rideBasePrice : Double) {
        self.rideBasePrice = rideBasePrice
        self.rideType = rideType
    }
    var body: some View {
        VStack(alignment: .leading){
                Image(imageNameForRideType(rideType))
                    .resizable()
                    .scaledToFit()
            
            VStack(alignment: .leading ,spacing: 4){
                    Text(rideType.name)
                    
                    // ride option price
                    Text(ridePriceForRideType(rideType , basePrice: rideBasePrice))
                } .font(.system(size: 14 , weight: .semibold))
                    .padding()
                
                
            }
            .frame(width: 120, height: 150)
        }
    
    
    func imageNameForRideType(_ rideType : RideType) -> String {
        switch rideType {
        case .uberX , .uberXL : return "uber-x"
        case .uberBlack : return "uber-black"
        }
    }
    
    func ridePriceForRideType(_ rideType : RideType , basePrice: Double? ) -> String {
        guard let price = basePrice else {return "no price"}
        return "\(price * rideType.rate)"
    }
}

#Preview {
    RideOptionView(rideType: .uberX, rideBasePrice: 22.09)
}
