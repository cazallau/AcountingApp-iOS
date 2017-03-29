//
//  NewSellViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 18/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class NewSellViewController: UIViewController {
    
    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var quanty: UITextField!
    @IBOutlet weak var clientIdentifier: UITextField!
    @IBOutlet weak var price: UITextField!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Nueva Venta"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = button
        let buttonCancel = UIBarButtonItem(image: UIImage(named: "Cancel"), style: .plain, target: self, action: #selector(cancel))
        self.navigationItem.leftBarButtonItem = buttonCancel
    }
    
    func save() {
        if product.text != "" && quanty.text != "" && price.text != "" && clientIdentifier.text != ""{
            let identifier = UUID().uuidString
            let date = DateFormatter()
            date.dateFormat = "dd/MM/yyyy"
            let dates = date.string(from: Date())
            let sell = Sells(identifier: identifier, product: product.text!, quanty: quanty.text!, price: price.text!, clientIdentifier: clientIdentifier.text!, date: dates)
            sell.save()
            
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
