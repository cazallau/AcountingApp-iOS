//
//  BuyViewController.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 16/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var buyTable: UITableView! {
        didSet {
            buyTable.dataSource = self
            buyTable.delegate = self
            buyTable.register(BuyTableViewCell.self)
            let searchBar = UISearchBar(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: buyTable.bounds.width, height: CGFloat(40))))
            searchBar.barStyle = .default
            searchBar.placeholder = "Buscar"
            buyTable.tableHeaderView = searchBar
            buyTable.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    var buys: [Buys] = [] {
        didSet {
            hideLoadingView()
            buyTable.reloadData()
        }
    }

    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Compras"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingView()
        let button = UIBarButtonItem(image: UIImage(named: "AddBuy"), style: .plain, target: self, action: #selector(plus))
        self.navigationItem.rightBarButtonItem = button
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Buys.getAll { buys in
            self.buys = buys
        }
    }
    
    func plus() {
        present(UINavigationController(rootViewController: NewBuyViewController()), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(buys[(indexPath as NSIndexPath).row].product)
        let myCell = buyTable.dequeueReusableCell() as BuyTableViewCell
        myCell.setBuy(buys[(indexPath as NSIndexPath).row])
        return myCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc(tableView:editActionsForRowAtIndexPath:) func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let button1 = UITableViewRowAction(style: .default, title: "Eliminar", handler: { (action, indexPath) in
            print("button1 pressed!")
            self.buys[(indexPath as NSIndexPath).row].remove(self.buys[(indexPath as NSIndexPath).row].identifier)
            self.buys.remove(at: (indexPath as NSIndexPath).row)
        })
        button1.backgroundColor = UIColor.red
        let button2 = UITableViewRowAction(style: .default, title: "Editar", handler: { (action, indexPath) in
            print("button2 pressed!")
            let navigationController = UINavigationController(rootViewController: EditBuyViewController(buy: self.buys[(indexPath as NSIndexPath).row]))
            
            self.present(navigationController, animated: true) {
            
            }
        })
        button2.backgroundColor = UIColor.lightGray
        return [button1, button2]
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    }

}
extension BuyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     let navigationController = UINavigationController(rootViewController: NewClientViewController())
     
     presentViewController(navigationController, animated: true) {
     
     }
     }*/
}
private extension BuyViewController {
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

