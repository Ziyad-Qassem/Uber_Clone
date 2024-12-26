//
//  SignupView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 26/12/2024.
//

import SwiftUI

struct SignupView: View {
    @Environment(\.dismiss) private var dismiss
    @State var email : String = ""
    @State var password : String = ""
    @State var userFullName : String = ""
    @EnvironmentObject var authManager : AuthenticationManager
    var body: some View {

        ZStack {
            
            Color(.black)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20){
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                }

                Text("Create new account")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                   
                Spacer()
                VStack{
                    VStack (spacing: 55  ){
                        
                        CustomInputFields(text: $userFullName, title: "Full Name", placeholder: "Enter your name")
                        
                        CustomInputFields(text: $email, title: "Email Address", placeholder: "name@example.com")
                        
                        CustomInputFields(text: $password, title: "Create Password", placeholder: "Enter your password", isSecureField: true)
                        
                    }.padding(.leading)
                    
                    Spacer()
                    // sing up button
                    Button {
                         authManager.createuser(with: email, password: password, fullName: userFullName)
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.white)
                            .overlay {
                                Text("Sign Up")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                            }.frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    }
                
                    Spacer()

                }
            } .padding()
        }.foregroundStyle(.white)
    }
}

#Preview {
    SignupView()
}
