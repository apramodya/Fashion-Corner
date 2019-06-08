//
//  HomeItem.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 8/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import Foundation
import Firebase

struct HomeItem {
    var name: String
    var id: String
    var imageUrl: String
    var order: Int
    var isActive: Bool
    var timeStamp: CVTimeStamp
    
    init(name: String, id: String, imageUrl: String, isActive: Bool = true, order: Int, timeStamp: CVTimeStamp) {
        self.name = name
        self.id = id
        self.imageUrl = imageUrl
        self.order = order
        self.isActive = isActive
        self.timeStamp = timeStamp
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.order = data["order"] as! Int
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamps"] as? CVTimeStamp ?? CVTimeStamp()
    }
}
