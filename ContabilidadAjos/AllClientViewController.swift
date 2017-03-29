//
//  AllClientViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 4/8/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class AllClientViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView! {
        didSet {
            table.dataSource = self
            table.delegate = self
            table.register(SellTableViewCell.self)
            /*let searchBar = UISearchBar(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: clientTable.bounds.width, height: CGFloat(40))))
            searchBar.barStyle = .Default
            searchBar.placeholder = "Buscar"
            clientTable.tableHeaderView = searchBar
            clientTable.tableFooterView = UIView()*/
            
        }

    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loadingLabel: UILabel!
    let client: Client
    var sells: [Sells] = [] {
        didSet {
            hideLoadingView()
            table.reloadData()
        }
    }
    init(client : Client){
        self.client = client
        super.init(nibName: nil, bundle: nil)
        
        title = client.name
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        Sells.getAllForClients(client.identifier) { sells in
            self.sells = sells
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = table.dequeueReusableCell() as SellTableViewCell
        myCell.setSell(sells[(indexPath as NSIndexPath).row])
        return myCell
    }
    
    /*func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }*/
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            sells[(indexPath as NSIndexPath).row].remove(sells[(indexPath as NSIndexPath).row].identifier)
            sells.remove(at: (indexPath as NSIndexPath).row)
        }
    }
    
}
extension AllClientViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     let navigationController = UINavigationController(rootViewController: NewClientViewController())
     
     presentViewController(navigationController, animated: true) {
     
     }
     }*/
}
private extension AllClientViewController {
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


