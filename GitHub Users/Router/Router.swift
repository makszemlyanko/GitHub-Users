//
//  Router.swift
//  GitHub Users
//
//  Created by Maks Kokos on 29.11.2022.
//

import UIKit

protocol RouterProtocol {
    func initialViewController()
    func pushToUserDetail(searchName: String)
}

final class Router: RouterProtocol {
    
    let navController: UINavigationController
    let builder: BuilderProtocol
    
    init(navController: UINavigationController, builder: BuilderProtocol) {
        self.navController = navController
        self.builder = builder
    }
    
    func initialViewController() {
        let usersListVC = builder.createUsersListModule(router: self)
        navController.setViewControllers([usersListVC], animated: true)
    }
    
    func pushToUserDetail(searchName: String) {
        let userDetailVC = builder.createUserDetailModule(searchName: searchName, router: self)
        navController.pushViewController(userDetailVC, animated: true)
    }
}
