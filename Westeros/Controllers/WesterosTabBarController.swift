//
//  WesterosTabBarController.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 29/09/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

class WesterosTabBarController: UITabBarController {
    
    // MARK: - Properties
    let houses : HouseListViewController
    let seasons : SeasonListViewController

    // MARK: - Initialization
    init(houses: HouseListViewController, seasons: SeasonListViewController) {
        self.houses = houses
        self.seasons = seasons
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTabBars()
    }
    
    func createTabBars() {
        self.viewControllers = [houses.wrappredInNavigation(), seasons.wrappredInNavigation()]
        
        tabBar.items![0].image = UIImage(named: "ShieldIcon")
        tabBar.items![1].image = UIImage(named: "SeasonIcon")
        
        title = viewControllers?.first?.title
    }
    
    // MARK: - TabBar Delegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            switch item.title! {
            case houses.title:
                let houseDetailViewController = HouseDetailViewController(model: houses.lastSelectedHouse())
                
                houses.delegate = houseDetailViewController
                splitViewController?.showDetailViewController(houseDetailViewController.wrappredInNavigation(), sender: nil)
            case seasons.title:
                let seasonDetailViewController = SeasonDetailViewController(model: seasons.lastSelectedSeason())
                seasons.delegate = seasonDetailViewController
                splitViewController?.showDetailViewController(seasonDetailViewController.wrappredInNavigation(), sender: nil)
            default:
                return
            }
        }
    }
    
    
}


