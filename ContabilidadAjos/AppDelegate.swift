//
//  AppDelegate.swift
//  ContabilidadAjos
//
//  Created by Antonio Jesús Cazalla Ureña on 16/7/16.
//  Copyright © 2016 Antonio Jesús Cazalla Ureña. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let clientViewController = ClientViewController()
        
        let clientNavigationController = UINavigationController(rootViewController: clientViewController)
        let buyNavigationController = UINavigationController (rootViewController: BuyViewController())
        let sellNavigationController = UINavigationController (rootViewController: SellViewController())
        let providerNavigationController = UINavigationController (rootViewController: ProviderViewController(showForSelection: false))
        let tabBarController = UITabBarController()
        clientNavigationController.tabBarItem = UITabBarItem (title: clientNavigationController.title, image: UIImage (named: "Contacts.png"), selectedImage: nil)
        buyNavigationController.tabBarItem = UITabBarItem (title: buyNavigationController.title, image: UIImage (named: "buy.png"), selectedImage: nil)
        sellNavigationController.tabBarItem = UITabBarItem (title: sellNavigationController.title, image: UIImage (named: "sell.png"), selectedImage: nil)
        providerNavigationController.tabBarItem = UITabBarItem (title: providerNavigationController.title, image: UIImage (named: "provider.png" ), selectedImage: nil)
        tabBarController.viewControllers = [clientNavigationController, providerNavigationController, buyNavigationController, sellNavigationController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

}

