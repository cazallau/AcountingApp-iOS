//
//  BuyTableViewCell.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 22/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class BuyTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var clientIdentifier: UILabel!
    @IBOutlet weak var date: UILabel!

    func setBuy(_ buy: Buys) {
        product.text = buy.product
        clientIdentifier.text = buy.providerIdentifier
        date.text = buy.date
        
    }
    
}
