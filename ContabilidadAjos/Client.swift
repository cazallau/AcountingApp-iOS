//
//  Client.swift
//  AjosHermanosCazalla
//
//  Created by Antonio Jesús Cazalla Ureña on 22/5/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Client {
    
    let identifier: String
    let name: String
    let direction: String
    let city: String
    let province: String
    
    
    func save() {
        let database = FIRDatabase.database().reference()
        let client = database.child("clients").child(identifier)
        client.child("name").setValue(name)
        client.child("direction").setValue(direction)
        client.child("city").setValue(city)
        client.child("province").setValue(province)
    }
    func remove(_ identifier: String){
        let database = FIRDatabase.database().reference()
        database.child("clients").child(identifier).removeValue()
        
    }
    
    static func get(_ identifier: String, response: @escaping (Client) -> ()) {
        let database = FIRDatabase.database().reference()
        database.child("clients").child(identifier).observeSingleEvent(of: .value, with: { user in
            let client = mapFirebaseClient(user)
            
            response(client)
        })
    }
    
    static func getAll(_ response: @escaping ([Client]) -> ()) {
        let database = FIRDatabase.database().reference()
        database.child("clients").observeSingleEvent(of: .value, with: { (firebaseClients) in
            var clients: [Client] = []
            for firebaseClient in firebaseClients.children {
                let client = mapFirebaseClient(firebaseClient as! FIRDataSnapshot)
                clients.append(client)
            }
            
            response(clients)
        })
    }
}

private extension Client {
    
    static func mapFirebaseClient(_ firebaseClient: FIRDataSnapshot) -> Client {
        let identifier = firebaseClient.key
        let name = (firebaseClient.value!as? NSDictionary)?["name"] as? String ?? ""
        let direction = (firebaseClient.value!as? NSDictionary)?["direction"] as? String ?? ""
        let city = (firebaseClient.value!as? NSDictionary)?["city"] as? String ?? ""
        let province = (firebaseClient.value!as? NSDictionary)?["province"] as? String ?? ""
        
        return Client(identifier: identifier, name: name, direction: direction, city: city, province: province)
    }
}
