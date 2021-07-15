//
//  MainCoordinator.swift
//  TestNavController
//
//  Created by Vitaliy on 07.07.2021.
//

import UIKit

class MainCoordinator {
    let window: UIWindow
    let firstViewController = FirstViewController()
    
    init(window: UIWindow?) {
        guard let window = window else {
            fatalError()
        }
        self.window = window
    }
    
    public func start() {
        let navController = CustomNavigtionController(rootViewController: firstViewController)
        navController.isNavigationBarHidden = false
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
