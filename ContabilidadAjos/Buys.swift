//
//  Buys.swift
//  AjosHermanosCazalla
//
//  Created by Antonio Jesús Cazalla Ureña on 2/6/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import Foundation
import Firebase

struct Buys {
    let identifier : String
    let product : String
    let quanty : String
    let price : String
    let providerIdentifier : String
    let date : String
    let estate : String
    
    func save() {
        let database = FIRDatabase.database().reference()
        let buy = database.child("compras").child(identifier)
        buy.child("product").setValue(product)
        buy.child("quanty").setValue(quanty)
        buy.child("price").setValue(price)
        buy.child("providerIdentifier").setValue(providerIdentifier)
        buy.child("date").setValue(date)
        buy.child("estate").setValue(estate)
    }
    
    func remove(_ identifier: String){
        let database = FIRDatabase.database().reference()
        database.child("compras").child(identifier).removeValue()
        
    }
    
    static func getAll(_ response: @escaping ([Buys]) -> ()) {
        let database = FIRDatabase.database().reference()
        database.child("compras").observeSingleEvent(of: .value, with: { (firebaseBuys) in
            var buys: [Buys] = []
            
            for firebaseBuys in firebaseBuys.children {
                let buy = mapFirebaseBuys(firebaseBuys as! FIRDataSnapshot)
                buys.append(buy)
            }
            
            response(buys)
        })
    }
    
    static func getAllForProvider(_ provider: String, response: @escaping ([Buys]) -> ()) {
        let database = FIRDatabase.database().reference()
        database.child("compras").observeSingleEvent(of: .value, with: { (firebaseBuys) in
            var buys: [Buys] = []
            
            for firebaseBuys in firebaseBuys.children {
                let buy = mapFirebaseBuys(firebaseBuys as! FIRDataSnapshot)
                if provider == buy.providerIdentifier {
                    buys.append(buy)
                }
            }
            
            response(buys)
        })
    }
}


private extension Buys {
 
    static func mapFirebaseBuys(_ firebaseBuys: FIRDataSnapshot) -> Buys {
        let identifier = firebaseBuys.key
        let product = (firebaseBuys.value!as? NSDictionary)?["product"] as? String ?? ""
        let quanty = (firebaseBuys.value!as? NSDictionary)?["quanty"] as? String ?? ""
        let price = (firebaseBuys.value!as? NSDictionary)?["price"] as? String ?? ""
        let providerIdentifier = (firebaseBuys.value!as? NSDictionary)?["providerIdentifier"] as? String ?? ""
        let date = (firebaseBuys.value!as? NSDictionary)?["date"] as? String ?? ""
        let estate = (firebaseBuys.value!as? NSDictionary)?["estate"] as? String ?? ""
        
        return Buys(identifier: identifier, product: product, quanty: quanty, price: price, providerIdentifier: providerIdentifier, date: date, estate: estate)
    }
}
