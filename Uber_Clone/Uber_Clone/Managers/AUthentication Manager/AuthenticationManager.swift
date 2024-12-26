//
//  File.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 26/12/2024.
//

import Foundation
import FirebaseAuth
import Firebase
class AuthenticationManager : ObservableObject{
    @Published var userSession : FirebaseAuth.User?
    
    init(){
        userSession = Auth.auth().currentUser
    }
    
    func createuser(with email : String , password : String , fullName: String){
    
        Auth.auth().createUser(withEmail: email , password: password) { result , error in
            if let error = error {
                print("DEBUG: Error creating user in AuthenticationManager \(error.localizedDescription)")
                return 
            }
            
            guard let firebaseUser = result?.user else{return}
            
            self.userSession = firebaseUser
            
            let userModel = UserModel(fullName: fullName, email: email, uid: firebaseUser.uid)
            DataBaseManager.shared.uploadUserData(for: userModel )
        }
    }
    
    func signinUser(with email : String , password : String)  {
        Auth.auth().signIn(withEmail: email, password: password){ result , error in
            if let error = error {
                print("DEBUG: Error logging in  user in AuthenticationManager \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else{return}
            self.userSession = user
           
        }
    }
    
    func signoutUser() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        }
        catch {
            print("DEBUG: Error signing out user in AuthenticationManager \(error.localizedDescription)")
        }
    }
}

