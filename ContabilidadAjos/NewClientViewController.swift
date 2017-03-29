//
//  NewClientViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 18/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class NewClientViewController: UIViewController {
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var identifier: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var direction: UITextField!
    @IBOutlet weak var province: UITextField!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Nuevo Cliente"
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
        if identifier.text != "" && clientName.text != "" && direction.text != "" {
            let client = Client(identifier: identifier.text!, name: clientName.text!, direction: direction.text!, city: city.text!, province: province.text!)
            client.save()
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
