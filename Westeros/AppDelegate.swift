//
//  AppDelegate.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 6/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

@UIApplicationMain // Crea una instancia de UIApplication
class AppDelegate: UIResponder, UIApplicationDelegate { // Delegado de UIApplication

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 1 - Crear el modelo
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        /*
        // 2 - Crear controladores
        /*var controllers = [UIViewController]()
        // vc: [HouseDetailViewController]( = []
        for house in houses {
            controllers.append(HouseDetailViewController(model: house).wrappredInNavigation())
        }*/
        let controllers = houses.map {
            HouseDetailViewController(model: $0).wrappredInNavigation()
        }*/
        
        
        // MasterViewController
        let houseListViewController = HouseListViewController(model: houses)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        
        let seasonListViewController = SeasonListViewController(model: seasons)
        
        // DetailViewController
        let houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        //let seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        // Asignar delegados
        houseListViewController.delegate = houseDetailViewController
        //seasonListViewController.delegate = seasonDetailViewController
        
        print("Dispositivo: \(UIDevice.current.model)")
        if UIDevice.current.userInterfaceIdiom == .pad {
            print("Ejecuta como iPad")
        } else {
            print("Ejecuta como iPhone")
        }
        
        // Crear el combinador, es decir, el UISplitViewController
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            houseListViewController.wrappredInNavigation(),
            houseDetailViewController.wrappredInNavigation()
        ]
        
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.preferredPrimaryColumnWidthFraction = 0.40
        splitViewController.maximumPrimaryColumnWidth = 300
        
        // 3 - Crear los Navigation
        //let starkNC = starkVC.wrappredInNavigation()
        //let lannisterNC = lannisterVC.wrappredInNavigation() // Devuelve un nuevo NC
        let seasonListNC = seasonListViewController.wrappredInNavigation()
        //let seasonDetailNC = seasonDetailViewController.wrappredInNavigation()
        
        // 3 - Crear combinador
        // Uso de TabBar
//        let tabBarVC = UITabBarController()
//        tabBarVC.viewControllers = controllers
        
        
        // 3 - Asignar el rootVC
//        let rootViewController = tabBarVC
        let rootViewController = splitViewController//seasonListNC
        
        /* CollectionView */
//        let houseCollectionViewController = HouseCollectionViewController(model: houses)
//        let rootViewController = houseCollectionViewController
        /* CollectionView */
        
        window?.rootViewController = rootViewController
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

