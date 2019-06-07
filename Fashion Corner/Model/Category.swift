//
//  Category.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 2/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import Foundation
import Firebase

struct Category {
    var name: String
    var id: String
    var gender: String
    var imageUrl: String
    var isActive: Bool = true
    var timeStamp: CVTimeStamp
    var order: Int
    
    init(name: String, id: String, gender: String, imageUrl: String, isActive: Bool = true, timeStamp: CVTimeStamp, order: Int) {
        self.name = name
        self.id = id
        self.gender = gender
        self.imageUrl = imageUrl
        self.isActive = isActive
        self.timeStamp = timeStamp
        self.order = order
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.gender = data["gender"] as? String ?? "both"
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamps"] as? CVTimeStamp ?? CVTimeStamp()
        self.order = data["order"] as! Int
    }
    
    static func modelToData(category: Category) -> [String: Any] {
        let data: [String: Any] = [
            "name" : category.name,
            "id" : category.id,
            "gender": category.gender,
            "imageUrl" : category.imageUrl,
            "isActive" : category.isActive,
            "timeStamp" : category.timeStamp,
            "order" : category.order
        ]
        
        return data
    }
}
