//
//  ClientCellTableViewCell.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 20/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class ClientCellTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!

    func setClient(_ client: Client) {
        name.text = client.name
        city.text = client.city
    }
    
}
