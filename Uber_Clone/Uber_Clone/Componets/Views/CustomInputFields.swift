//
//  CustomInputFields.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 26/12/2024.
//

import SwiftUI

struct CustomInputFields: View {
    @Binding var text: String
    let title : String
    let placeholder : String
    var isSecureField : Bool = false
    
    private let screenWidth : CGFloat = { UIScreen.main.bounds.width }()
    
    var body: some View {
        VStack(alignment: .leading, spacing : 12){
            Text(title)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .foregroundStyle(.white)
                    .autocapitalization(.none)
            }else{
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .foregroundStyle(.white)
                
            }
            
            Rectangle()
                .foregroundStyle(Color(.init(white: 1, alpha: 0.3)))
                .frame(width: screenWidth - 32 ,height: 0.7)
        }
    }
}

#Preview {
    CustomInputFields(text: .constant(""), title: "title", placeholder: "placeholder")
}
