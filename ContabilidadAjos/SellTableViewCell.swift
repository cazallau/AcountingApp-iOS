//
//  SellTableViewCell.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 22/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class SellTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var date: UILabel!
    
    func setSell(_ sell: Sells) {
        clientName.text = sell.clientIdentifier
        product.text = sell.product
        date.text = sell.date
    }

   }
