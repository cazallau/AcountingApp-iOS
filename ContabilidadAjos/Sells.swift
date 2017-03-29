//
//  Sells.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 18/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import Foundation
import Firebase

struct Sells {
    let identifier : String
    let product : String
    let quanty : String
    let price : String
    let clientIdentifier : String
    let date : String
    
    func save() {
        let database = FIRDatabase.database().reference()
        let buy = database.child("ventas").child(identifier)
        buy.child("product").setValue(product)
        buy.child("quanty").setValue(quanty)
        buy.child("price").setValue(price)
        buy.child("clientIdentifier").setValue(clientIdentifier)
        buy.child("date").setValue(date)
    }
    
    func remove(_ identifier: String){
        let database = FIRDatabase.database().reference()
        database.child("ventas").child(identifier).removeValue()
    }
    
    static func getAll(_ response: @escaping ([Sells]) -> ()) {
        let database = FIRDatabase.database().reference()
        database.child("ventas").observeSingleEvent(of: .value, with: { (firebaseSells) in
            var sells: [Sells] = []
            
            for firebaseSells in firebaseSells.children {
                let sell = mapFirebaseSells(firebaseSells as! FIRDataSnapshot)
                sells.append(sell)
            }
            
            response(sells)
        })
    }
    
    static func getAllForClients(_ client: String, response: @escaping ([Sells]) -> ()) {
        let database = FIRDatabase.database().reference()
        database.child("ventas").observeSingleEvent(of: .value, with: { (firebaseSells) in
            var sells: [Sells] = []
            
            for firebaseSells in firebaseSells.children {
                let sell = mapFirebaseSells(firebaseSells as! FIRDataSnapshot)
                if client == sell.clientIdentifier {
                sells.append(sell)
                }
            }
            
            response(sells)
        })
    }
}

private extension Sells {
    
    static func mapFirebaseSells(_ firebaseSells: FIRDataSnapshot) -> Sells {
        let identifier = firebaseSells.key
        let product = (firebaseSells.value!as? NSDictionary)?["product"] as? String ?? ""
        let quanty = (firebaseSells.value!as? NSDictionary)?["quanty"] as? String ?? ""
        let price = (firebaseSells.value!as? NSDictionary)?["price"] as? String ?? ""
        let clientIdentifier = (firebaseSells.value!as? NSDictionary)?["clientIdentifier"] as? String ?? ""
        let date = (firebaseSells.value!as? NSDictionary)?["date"] as? String ?? ""
        return Sells(identifier: identifier, product: product, quanty: quanty, price: price, clientIdentifier: clientIdentifier, date: date)
    }
}



