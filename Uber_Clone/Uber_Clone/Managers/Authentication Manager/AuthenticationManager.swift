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
    @Published var currentUser : UserModel?
    init(){
        userSession = Auth.auth().currentUser
        Task{ try await fetchCurrentUser()}
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
            DatabaseManager.shared.uploadUserData(for: userModel )
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
    @MainActor
    func fetchCurrentUser() async throws {
        guard let userId = userSession?.uid else {return }
        do {
            let snapShot = try await Firestore.firestore().collection("users").document(userId).getDocument()
            let user = try snapShot.data(as: UserModel.self)
            currentUser = user
            print("DEBUGUSER: Fetched current user in AuthenticationManager \(user)")
            
        }catch{
        
        }
       
    }
}

