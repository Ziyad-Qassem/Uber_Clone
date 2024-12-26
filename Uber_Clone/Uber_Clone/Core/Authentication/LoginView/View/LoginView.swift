//
//  LoginView.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 26/12/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email : String = ""
    @State private var password : String = ""
    @EnvironmentObject var authManager : AuthenticationManager
    
    private let screenWidth : CGFloat = { UIScreen.main.bounds.width }()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                VStack {
                    // logo and name
                    VStack(spacing: -16){
                        Image("uber-icon")
                            .resizable()
                            .frame(width: 200 , height: 200)
                        Text("UBER")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    // input fields
                    VStack(spacing : 32) {
                        CustomInputFields(text: $email, title: "Email Address", placeholder: "name@example.com")
                        
                        CustomInputFields(text: $password, title: "Password", placeholder: "Enter your password", isSecureField: true)
                        
                        Button {
                            
                        } label: {
                            Text("Forgot Password?")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.top)
                        }.frame(maxWidth: .infinity , alignment: .trailing)
                        
                        
                    }
                    .padding(.top , 12)
                    .padding(.horizontal)
                    
                    // sign in options
                    VStack{
                        HStack(spacing: 24){
                            Rectangle()
                                .frame(width: 80 , height: 1)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                            
                            Text("Sign in with social")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            Rectangle()
                                .frame(width: 80 , height: 1)
                                .foregroundStyle(.white)
                                .opacity(0.5)
                            
                        }
                        
                        HStack(spacing: 25){
                            
                            Button {
                                
                            } label: {
                                Image("facebook-sign-in-icon")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                            }
                            
                            Button {
                                
                            } label: {
                                Image("google-sign-in-icon")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                            }
                        }
                    }.padding(.vertical)
                    
                    Spacer()
                    // sign in button
                    Button {
                       authManager.signinUser(with: email, password: password)
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .overlay {
                                HStack{
                                    Text("SIGN IN")
                                        .foregroundStyle(.black)
                                    
                                    Image(systemName: "arrow.right")
                                        .foregroundStyle(.black)
                                }
                            }.frame(width: screenWidth - 32, height: 50)
                            .foregroundStyle(.white)
                        
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    // sign up button
                    NavigationLink {
                        SignupView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack{
                            Text("Don't have and account?")
                            
                            Text("Sign up")
                                .fontWeight(.semibold)
                        }.foregroundStyle(.white)
                    }

                        
                    
                  
                }
            }
        
        }
    }
}

#Preview {
    LoginView()
}
