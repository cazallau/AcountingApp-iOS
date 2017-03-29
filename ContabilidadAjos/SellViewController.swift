//
//  SellViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 16/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class SellViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var sellTable: UITableView! {
        didSet {
            sellTable.dataSource = self
            sellTable.delegate = self
            sellTable.register(SellTableViewCell.self)
            let searchBar = UISearchBar(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: sellTable.bounds.width, height: CGFloat(40))))
            searchBar.barStyle = .default
            searchBar.placeholder = "Buscar"
            sellTable.tableHeaderView = searchBar
            sellTable.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    var sells: [Sells] = [] {
        didSet {
            hideLoadingView()
            sellTable.reloadData()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Ventas"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingView()
        let button = UIBarButtonItem(image: UIImage(named: "AddSell"), style: .plain, target: self, action: #selector(plus))
        
        self.navigationItem.rightBarButtonItem = button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Sells.getAll { sells in
            self.sells = sells
        }
    }
    
    func plus() {
        
        present(UINavigationController(rootViewController: NewSellViewController()), animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = sellTable.dequeueReusableCell() as SellTableViewCell
        myCell.setSell(sells[(indexPath as NSIndexPath).row])
        return myCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            sells[(indexPath as NSIndexPath).row].remove(sells[(indexPath as NSIndexPath).row].identifier)
            sells.remove(at: (indexPath as NSIndexPath).row)
        }
    }
    
}
extension SellViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     let navigationController = UINavigationController(rootViewController: NewClientViewController())
     
     presentViewController(navigationController, animated: true) {
     
     }
     }*/
}
private extension SellViewController {
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

