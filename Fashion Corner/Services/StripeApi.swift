//
//  StripeApi.swift
//  Fashion Corner
//
//  Created by Pramodya Abeysinghe on 18/6/19.
//  Copyright © 2019 Pramodya. All rights reserved.
//

import Foundation
import Stripe
import FirebaseFunctions

let StripeApi = _StripeApi()

final class _StripeApi: NSObject, STPEphemeralKeyProvider {
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let data = [
            "stripe_version" : apiVersion,
            "customer_id" : userService.user.stripeId
        ]
        
        Functions.functions().httpsCallable("createEphemeralKey").call(data) { (result, error) in
            if let error = error {
                print("Error")
                debugPrint(error.localizedDescription)
                completion(nil, error)
                return
            }
            
            guard let key = result?.data as? [String: Any] else {
                completion(nil, nil)
                return
            }
            
            completion(key, nil)
        }
    }
    
    
}
