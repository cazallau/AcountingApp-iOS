//
//  NewBuyViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 18/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class NewBuyViewController: UIViewController, ProviderViewControllerDelegate {

    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var quanty: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var provider: UITextField!
    @IBOutlet weak var estate: UITextField!

    @IBAction func plus(_ sender: AnyObject) {
        let providersViewController = ProviderViewController(showForSelection: true)
        providersViewController.delegate = self
        present(providersViewController, animated: true) {
            
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        title = "Nueva Compra"
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
        if product.text != "" && quanty.text != "" && price.text != "" {
            let identifier = UUID().uuidString
            let date = DateFormatter()
            date.dateFormat = "dd/MM/yyyy"
            let dates = date.string(from: Date())
            let buy = Buys(identifier: identifier, product: product.text!, quanty: quanty.text!, price: price.text!, providerIdentifier: provider.text!, date: dates, estate: estate.text!)
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

    func selectProvider(_ selectedProvider: Provider) {
        provider.text = selectedProvider.name
    }
}


