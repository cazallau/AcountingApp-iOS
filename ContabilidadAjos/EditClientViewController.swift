//
//  EditClientViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 22/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class EditClientViewController: UIViewController {
    
    @IBOutlet weak var named: UITextField!  {
        didSet{
            named.text = clients.name
        }
    }
    @IBOutlet weak var dni: UITextField!
    @IBOutlet weak var direction: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var province: UITextField!
    var clients = Client(identifier: "", name: "", direction:"", city: "", province: "")
    
    init(client : Client){
        super.init(nibName: nil, bundle: nil)
        clients = client
        title = "Editar \(client.name)"
        
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
       // named.text? = clients.name
        dni.text = clients.identifier
        direction.text = clients.direction
        city.text = clients.city
        province.text = clients.province
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        if dni.text != "" && named.text != "" && direction.text != "" {
            let client = Client(identifier: dni.text!, name: named.text!, direction: direction.text!, city: city.text!, province: province.text!)
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
