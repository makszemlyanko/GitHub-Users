//
//  Router.swift
//  GitHub Users
//
//  Created by Maks Kokos on 29.11.2022.
//

import UIKit

protocol RouterProtocol {
    var navController: UINavigationController { get set }
    var builder: BuilderProtocol { get set }
    
    init(navController: UINavigationController, builder: BuilderProtocol)
    
    func initialViewController()
    func showUserDetail()
    // func popToRoot()
}

final class Router: RouterProtocol {
    
    var navController: UINavigationController
    var builder: BuilderProtocol
    
    init(navController: UINavigationController, builder: BuilderProtocol) {
        self.navController = navController
        self.builder = builder
    }
    
    func initialViewController() {
        let usersListVC = builder.createUsersListModule(router: self)
        navController.setViewControllers([usersListVC], animated: true)
    }
    
    func showUserDetail() {
        
    }
    
    
}




