//
//  User.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 11/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var email: String
    var stripeId: String
    
    init(id: String, email: String, stripeId: String) {
        self.id = id
        self.email = email
        self.stripeId = stripeId
    }
    
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.stripeId = data["stripeId"] as? String ?? ""
    }
    
    static func modelToData(user: User) -> [String: Any]{
        let data : [String: Any] = [
            "id": user.id,
            "email": user.email,
            "stripeId" : user.stripeId
        ]
        
        return data
    }
}
