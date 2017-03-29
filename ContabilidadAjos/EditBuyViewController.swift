//
//  EditBuyViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 6/8/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class EditBuyViewController: UIViewController {
    @IBOutlet weak var product: UITextField! {
        didSet {
            product.text = buy.product
        }
    }

    @IBOutlet weak var quanty: UITextField! {
        didSet {
            quanty.text = buy.quanty
        }
    }

    @IBOutlet weak var price: UITextField! {
        didSet {
            price.text = buy.price
        }
    }

    @IBOutlet weak var providerIdentifier: UITextField! {
        didSet {
            providerIdentifier.text = buy.providerIdentifier
        }
    }

    @IBOutlet weak var estate: UITextField! {
        didSet {
            estate.text = buy.estate
        }
    }
    
    let buy: Buys
    
    init (buy: Buys) {
        self.buy = buy
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        let button = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = button
        let buttonCancel = UIBarButtonItem(image: UIImage(named: "Cancel"), style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = buttonCancel
    }
    
    func save() {
        if product.text != "" && quanty.text != "" && price.text != "" && providerIdentifier.text != ""{
            let identifier = self.buy.identifier
            let date = self.buy.date
            let buy = Buys(identifier: identifier, product: product.text!, quanty: quanty.text!, price: price.text!, providerIdentifier: providerIdentifier.text!, date: date, estate: estate.text!)
            buy.save()
            dismiss(animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "ERROR", message: "Debe rellenar los campos", preferredStyle: .alert)
            let accept = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alertController.addAction(accept)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func cancel() {
        dismiss(animated: true, completion: nil)
    }

}
