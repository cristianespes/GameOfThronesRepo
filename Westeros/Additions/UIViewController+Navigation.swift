//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by CRISTIAN ESPES on 12/9/18.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappredInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
