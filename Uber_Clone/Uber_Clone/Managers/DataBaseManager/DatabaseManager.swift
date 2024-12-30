//
//  File.swift
//  Uber_Clone
//
//  Created by Ziyad Qassem on 27/12/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
final class DatabaseManager {
     static let shared = DatabaseManager()
    
    func uploadUserData(for user: UserModel) {
            guard let encodedUser = try? Firestore.Encoder().encode(user) else{
                print("DEBUG: Error uploading user data in DataBaseManager")
                return }
          Firestore.firestore().collection("users").document(user.uid).setData(encodedUser)
    }
    func fetchUserData(for user: UserModel) async throws -> UserModel?{
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(user.uid).getDocument()
            
            guard let  data = try? snapshot.data(as:   UserModel.self ) else {
                print("DEBUG: error in fetching user data in DataBaseManager")
                return nil}
        
                return data
            
        }
        catch {
            print("DEBUG: error in fetching user data in DataBaseManager \(error.localizedDescription)")
            return nil
        }
        
    }
    func updateUserSavedLocations(with location : SavedLocation, locationType : SavedLocationOption) {
        guard let id = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error updating user data in DataBaseManager")
            return
        }
        guard let encodedLocation = try? Firestore.Encoder().encode(location) else {return}
        Firestore.firestore().collection("users").document(id).updateData([locationType.databasekey : encodedLocation])
    }
   
   
}
