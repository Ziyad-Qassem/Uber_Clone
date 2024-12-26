//
//  RideRequestView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 25/12/2024.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType : RideType = .uberX
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    var body: some View {
        VStack{
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 50 ,height: 6)
                .padding(.bottom , 4)
            
        // header view
            HStack(spacing : 15){
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 40)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                VStack {
                    HStack {
                        Text("Current Loation")
                            .foregroundStyle(.gray)
                            .frame(height: 25)
                        
                        Spacer()
                       
                        //ride start time
                        Text(locationViewModel.pickupTime ?? "no time")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            
                    }.padding(.trailing)
                    
                    Divider()
                        
                    HStack{
                        Text(locationViewModel.seletedLocation?.title ?? "NO Destination")
                            .frame(height: 25)
                      
                        Spacer()
                        
                        //ride arriving time
                        Text(locationViewModel.dropOffTime ?? "no time")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .padding(.trailing)
                    }
                }
            }
        // ride suggestions View
            
            Divider()
            
            Text("SUGGESTED RIDES")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.gray)
                .padding(.vertical)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack{
                    ForEach(RideType.allCases){ ride in
                        RideOptionView(rideType: ride, rideBasePrice: 30.50)
                            .onTapGesture(perform: {
                                withAnimation(.spring()){
                                    selectedRideType = ride
                                }
                            })
                            .foregroundStyle(Color(ride == selectedRideType ? .white : Color.theme.primaryTextColor))
                            .scaleEffect(ride == selectedRideType ? 1.2 : 1.0)
                            .background(ride == selectedRideType ? Color( .systemBlue) : Color.theme.secondaryBackgroundColor)
                            .cornerRadius(10)
                        
                    }
                }
            }
            
            Divider().padding(.vertical , 4)
            // paymentView
            
            UserPaymentView()
                .background(Color.theme.secondaryBackgroundColor)
              
            // confirm ride button
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width : UIScreen.main.bounds.width  - 30 , height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundStyle(.white)
                    .padding(.vertical)
            }

            
    
        }.padding(.bottom , 24)
            .padding(.leading, 8)
            .background(Color.theme.backgroundColor)
            .cornerRadius(16)
    }
}

#Preview {
    RideRequestView()
}
