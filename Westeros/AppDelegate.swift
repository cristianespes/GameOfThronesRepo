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

    var splitViewController: UISplitViewController!
    var seasonDetailViewController: SeasonDetailViewController!
    var houseDetailViewController: HouseDetailViewController!
    var houseListNavigation: UINavigationController!
    var seasonListNavigation: UINavigationController!
    
    var houseDetailNavigation: UINavigationController!
    var seasonDetailNavigation: UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Delay of LaunchScreen
        Thread.sleep(forTimeInterval: 3.0)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 1 - Crear el modelo
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        
        // 2 - Crear controladores del SplitViewController
        // MasterViewController
        let houseListViewController = HouseListViewController(model: houses)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        houseDetailViewController = HouseDetailViewController(model: lastHouseSelected)
        
        let seasonListViewController = SeasonListViewController(model: seasons)
        let lastSeasonSelected = seasonListViewController.lastSelectedSeason()
        seasonDetailViewController = SeasonDetailViewController(model: lastSeasonSelected)
        
        // Asignar delegados
        if UIDevice.current.userInterfaceIdiom == .pad {
            houseListViewController.delegate = houseDetailViewController
            seasonListViewController.delegate = seasonDetailViewController
        } else {
            houseListViewController.delegate = houseListViewController
            seasonListViewController.delegate = seasonListViewController
        }
        
        // Crear los Navigation
        houseListNavigation = houseListViewController.wrappedInNavigation()
        seasonListNavigation = seasonListViewController.wrappedInNavigation()
        houseDetailNavigation = houseDetailViewController.wrappedInNavigation()
        seasonDetailNavigation = seasonDetailViewController.wrappedInNavigation()
        
        
        // 3 - Crear combinador del TabBarController
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [houseListNavigation, seasonListNavigation]
        tabBarController.delegate = self
        
        // Personalización de TabBarController
        tabBarController.tabBar.barTintColor = .burlywood
        tabBarController.tabBar.tintColor = .maroon
        if #available(iOS 10.0, *) {
            tabBarController.tabBar.unselectedItemTintColor = .white
        }
        tabBarController.tabBar.items![0].image = UIImage(named: "ShieldIcon")
        tabBarController.tabBar.items![0].title = houseListViewController.title?.uppercased()
        tabBarController.tabBar.items![1].image = UIImage(named: "SeasonIcon")
        tabBarController.tabBar.items![1].title = seasonListViewController.title?.uppercased()
        
        // 4 - Creamos el UISplitViewController y le asignamos los viewControllers
        splitViewController = UISplitViewController()
        splitViewController.viewControllers = [tabBarController, houseDetailNavigation, seasonDetailNavigation]
        
        // Ajustes del SplitView
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.preferredPrimaryColumnWidthFraction = 0.40
        splitViewController.maximumPrimaryColumnWidth = 300
        /*[houseDetailViewController, seasonDetailViewController].forEach {
            $0.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        }*/
        
        
        // 5 - Asignar el rootVC
        let rootViewController = splitViewController
        
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

extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first else { return }
        
        let detailNavigation: UINavigationController
        if type(of: viewController ) == SeasonListViewController.self {
            detailNavigation = seasonDetailNavigation
        } else {
            detailNavigation = houseDetailNavigation
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            splitViewController.showDetailViewController(detailNavigation, sender: nil)
        }
    }
}
