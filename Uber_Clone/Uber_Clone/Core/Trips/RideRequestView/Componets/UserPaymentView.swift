//
//  UserPaymentView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 25/12/2024.
//

import SwiftUI

struct UserPaymentView: View {
    var body: some View {
        HStack(spacing: 12){
            Text("Visa")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(6)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(4)
                .padding(.leading, 10)
        
            
            Text("****123")
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
                    .frame(height: 60)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .foregroundStyle(.black)
            }

        
        }
        .background(Color(.systemGroupedBackground))
        .cornerRadius(10)
    }
}

#Preview {
    UserPaymentView()
}
