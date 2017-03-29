//
//  AllProviderViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 6/8/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class AllProviderViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var table: UITableView! {
        didSet {
            table.dataSource = self
            table.delegate = self
            table.register(BuyTableViewCell.self)
            /*let searchBar = UISearchBar(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: clientTable.bounds.width, height: CGFloat(40))))
             searchBar.barStyle = .Default
             searchBar.placeholder = "Buscar"
             clientTable.tableHeaderView = searchBar
             clientTable.tableFooterView = UIView()*/
            
        }
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var labelLoading: UILabel!
    
    let provider: Provider
    var buys: [Buys] = [] {
        didSet {
            hideLoadingView()
            table.reloadData()
        }
    }
    init(provider : Provider){
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
        
        title = provider.name
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        showLoadingView()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        Buys.getAllForProvider(provider.identifier) { buys in
            self.buys = buys
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return buys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = table.dequeueReusableCell() as BuyTableViewCell
        myCell.setBuy(buys[(indexPath as NSIndexPath).row])
        return myCell
    }
    
    /*func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     return true
     }*/
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            buys[(indexPath as NSIndexPath).row].remove(buys[(indexPath as NSIndexPath).row].identifier)
            buys.remove(at: (indexPath as NSIndexPath).row)
        }
    }
    
}
extension AllProviderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     let navigationController = UINavigationController(rootViewController: NewClientViewController())
     
     presentViewController(navigationController, animated: true) {
     
     }
     }*/
}
private extension AllProviderViewController {
    func showLoadingView() {
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.white
        labelLoading.isHidden = false
    }
    
    func hideLoadingView() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        labelLoading.isHidden = true
    }
}



