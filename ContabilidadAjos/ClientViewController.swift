//
//  ClientViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 16/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class ClientViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var clientTable: UITableView! {
            didSet {
                clientTable.dataSource = self
                clientTable.delegate = self
                clientTable.register(ClientCellTableViewCell.self)
                let searchBar = UISearchBar(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: clientTable.bounds.width, height: CGFloat(40))))
                searchBar.barStyle = .default
                searchBar.placeholder = "Buscar"
                clientTable.tableHeaderView = searchBar
                clientTable.tableFooterView = UIView()

        }
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!

    var clients: [Client] = [] {
        didSet {
            hideLoadingView()
            clientTable.reloadData()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        title = "Clientes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIBarButtonItem(image: UIImage(named: "AddClient"), style: .plain, target: self, action: #selector(plus))
        self.navigationItem.rightBarButtonItem = button
        
        showLoadingView()
    }

    override func viewWillAppear(_ animated: Bool) {
        Client.getAll { clients in
            self.clients = clients
        }
        
    }

    func plus() {
      present(UINavigationController(rootViewController: NewClientViewController()), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = clientTable.dequeueReusableCell() as ClientCellTableViewCell
        myCell.setClient(clients[(indexPath as NSIndexPath).row])
        return myCell
    }
    
}
extension ClientViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(AllClientViewController(client: clients[(indexPath as NSIndexPath).row]), animated: true)
    }
    
    @objc(tableView:canEditRowAtIndexPath:) func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let button1 = UITableViewRowAction(style: .default, title: "Eliminar", handler: { (action, indexPath) in
            print("button1 pressed!")
            self.clients[(indexPath as NSIndexPath).row].remove(self.clients[(indexPath as NSIndexPath).row].identifier)
            self.clients.remove(at: (indexPath as NSIndexPath).row)
        })
        button1.backgroundColor = UIColor.red
        let button2 = UITableViewRowAction(style: .default, title: "Editar", handler: { (action, indexPath) in
            print("button2 pressed!")
            let navigationController = UINavigationController(rootViewController: EditClientViewController(client: self.clients[(indexPath as NSIndexPath).row]))
            
            self.present(navigationController, animated: true) {
                
            }

        })
        button2.backgroundColor = UIColor.lightGray
        return [button1, button2]
    }
    
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
}

private extension ClientViewController {
    func showLoadingView() {
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        loadingLabel.isHidden = false
    }
    
    func hideLoadingView() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        loadingLabel.isHidden = true
    }
}


