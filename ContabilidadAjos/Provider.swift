//
//  Provider.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 18/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Provider {
    
    let identifier: String
    let name: String
    let direction: String
    let city: String
    let province: String
    
    
    func save() {
        let database = FIRDatabase.database().reference()
        let provider = database.child("providers").child(identifier)
        provider.child("name").setValue(name)
        provider.child("direction").setValue(direction)
        provider.child("city").setValue(city)
        provider.child("province").setValue(province)
    }
    
    func remove(_ identifier: String){
        let database = FIRDatabase.database().reference()
        database.child("providers").child(identifier).removeValue()
        
    }
    
    static func get(_ identifier: String, response: @escaping (Provider) -> ()) {
        let database = FIRDatabase.database().reference()
        database.child("providers").child(identifier).observeSingleEvent(of: .value, with: { user in
            let provider = mapFirebaseProvider (user)
            
            response(provider)
        })
    }
    
    static func getAll(_ response: @escaping ([Provider]) -> ()) {
        let database = FIRDatabase.database().reference()
        database.child("providers").observeSingleEvent(of: .value, with: { (firebaseProvider) in
            var providers: [Provider] = []
            
            for firebaseProvider in firebaseProvider.children {
                let provider = mapFirebaseProvider(firebaseProvider as! FIRDataSnapshot)
                providers.append(provider)
            }
            
            response(providers)
        })
    }
}

private extension Provider {
    
    static func mapFirebaseProvider(_ firebaseProvider: FIRDataSnapshot) -> Provider {
        let identifier = firebaseProvider.key
        let name = (firebaseProvider.value!as? NSDictionary)?["name"] as? String ?? ""
        let direction = (firebaseProvider.value!as? NSDictionary)?["direcction"] as? String ?? ""
        let city = (firebaseProvider.value!as? NSDictionary)?["product"] as? String ?? ""
        let province = (firebaseProvider.value!as? NSDictionary)?["province"] as? String ?? ""
        
        return Provider(identifier: identifier, name: name, direction: direction, city: city, province: province)
    }
}
