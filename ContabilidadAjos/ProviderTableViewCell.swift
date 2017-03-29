//
//  ProviderTableViewCell.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 20/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class ProviderTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!
    func setProvider(_ provider: Provider) {
        name.text = provider.name
        city.text = provider.city
        
    }

    
    
}
