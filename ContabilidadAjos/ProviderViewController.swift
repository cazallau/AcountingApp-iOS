//
//  ProviderViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 16/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

protocol ProviderViewControllerDelegate {
    func selectProvider(_ provider: Provider)
}

class ProviderViewController: UIViewController, UITableViewDataSource {
    
    var delegate: ProviderViewControllerDelegate?
    
    @IBOutlet weak var providerTable: UITableView! {
        didSet {
            providerTable.dataSource = self
            providerTable.delegate = self
            providerTable.register(ProviderTableViewCell.self)
            let searchBar = UISearchBar(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: providerTable.bounds.width, height: CGFloat(40))))
            searchBar.barStyle = .default
            searchBar.placeholder = "Buscar"
            providerTable.tableHeaderView = searchBar
            providerTable.tableFooterView = UIView()
        }
    }

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    var providers: [Provider] = [] {
        didSet {
            hideLoadingView()
            providerTable.reloadData()
        }
    }
    let showForSelection: Bool
    
    init(showForSelection: Bool) {
        self.showForSelection = showForSelection
        super.init(nibName: nil, bundle: nil)
        title = "Proveedores"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingView()
        let button = UIBarButtonItem(image: UIImage(named: "AddClient"), style: .plain, target: self, action: #selector(plus))
        self.navigationItem.rightBarButtonItem = button
        Provider.getAll { providers in
            self.providers = providers
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Provider.getAll { providers in
            self.providers = providers
        }
    }
    
    func plus() {
        
        present(UINavigationController(rootViewController: NewProviderViewController()), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = providerTable.dequeueReusableCell() as ProviderTableViewCell
        myCell.setProvider(providers[(indexPath as NSIndexPath).row])
        return myCell
    }
}

extension ProviderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if showForSelection {
            dismiss(animated: true, completion: nil)
            
            delegate?.selectProvider(providers[(indexPath as NSIndexPath).row])
        } else {
            navigationController?.pushViewController(AllProviderViewController(provider: providers[(indexPath as NSIndexPath).row]), animated: true)
        }
    }
    @objc(tableView:canEditRowAtIndexPath:) func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let button1 = UITableViewRowAction(style: .default, title: "Eliminar", handler: { (action, indexPath) in
            print("button1 pressed!")
            self.providers[(indexPath as NSIndexPath).row].remove(self.providers[(indexPath as NSIndexPath).row].identifier)
            self.providers.remove(at: (indexPath as NSIndexPath).row)
        })
        button1.backgroundColor = UIColor.red
        let button2 = UITableViewRowAction(style: .default, title: "Editar", handler: { (action, indexPath) in
            print("button2 pressed!")
            let navigationController = UINavigationController(rootViewController: EditProviderViewController(provider: self.providers[(indexPath as NSIndexPath).row]))
            
            self.present(navigationController, animated: true) {
                
            }
            
        })
        button2.backgroundColor = UIColor.lightGray
        return [button1, button2]
    }
    
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }
}

private extension ProviderViewController {
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


