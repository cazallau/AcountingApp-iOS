//
//  EditProviderViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 2/8/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class EditProviderViewController: UIViewController {

    @IBOutlet weak var name: UITextField! {
        didSet {
            name.text = provider.name
        }
    }
    
    @IBOutlet weak var dni: UITextField! {
        didSet {
            dni.text = provider.identifier
        }
    }

    @IBOutlet weak var direction: UITextField! {
        didSet {
            direction.text = provider.direction
        }
    }

    @IBOutlet weak var city: UITextField! {
        didSet {
            city.text = provider.city
        }
    }

    @IBOutlet weak var province: UITextField! {
        didSet {
            province.text = provider.province
        }
    }

    var provider = Provider(identifier: "", name: "", direction:"", city: "", province: "")
    init(provider: Provider){
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
        
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
        if dni.text != "" && name.text != "" && direction.text != "" {
            let provider = Provider(identifier: dni.text!, name: name.text!, direction: direction.text!, city: city.text!, province: province.text!)
            provider.save()
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
