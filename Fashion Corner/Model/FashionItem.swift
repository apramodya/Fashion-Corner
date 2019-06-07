//
//  FashionItem.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 7/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import Foundation
import Firebase

struct FashionItem {
    var name: String
    var id: String
    var category: String
    var gender: String
    var price: Double
    var discountPercentage: Double
    var imageUrl: String
    var isActive: Bool = true
    var timeStamp: CVTimeStamp
    
    init(name: String, id: String, category: String, price: Double, discountPercentage: Double, gender: String, imageUrl: String, isActive: Bool = true, timeStamp: CVTimeStamp) {
        self.name = name
        self.id = id
        self.category = category
        self.price = price
        self.discountPercentage = discountPercentage
        self.gender = gender
        self.imageUrl = imageUrl
        self.isActive = isActive
        self.timeStamp = timeStamp
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.category = data["category"] as? String ?? ""
        self.price = data["price"] as? Double ?? 0.0
        self.discountPercentage = data["discountPercentage"] as? Double ?? 0.0
        self.gender = data["gender"] as? String ?? "both"
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamps"] as? CVTimeStamp ?? CVTimeStamp()
    }
    
    static func modelToData(item: FashionItem) -> [String: Any] {
        let data: [String: Any] = [
            "name" : item.name,
            "id" : item.id,
            "category" : item.id,
            "price" : item.price,
            "discountPercentage" : item.discountPercentage,
            "gender": item.gender,
            "imageUrl" : item.imageUrl,
            "isActive" : item.isActive,
            "timeStamp" : item.timeStamp
        ]
        
        return data
    }
}
