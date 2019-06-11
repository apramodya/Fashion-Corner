//
//  UserService.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 11/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

let userService = _UserSerivce()

final class _UserSerivce {
    var user = User(data: ["":""])
    let auth = Auth.auth()
    let db = Firestore.firestore()
    var userListner: ListenerRegistration? = nil
    
    var isGuest: Bool {
        guard let authUser = auth.currentUser else {
            return true
        }
        
        if authUser.isAnonymous {
            return true
        } else {
            return false
        }
    }
    
    func getCurrentUser() {
        guard let authUser = auth.currentUser else { return }
        
        let userRef = db.collection("users").document(authUser.uid)
        userListner = userRef.addSnapshotListener({ (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let data = snap?.data() else { return}
            self.user = User(data: data)
        })
    }
    
    func logoutUser() {
        userListner?.remove()
        userListner = nil
        user = User(data: ["":""])
    }
}
