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
    let assembly: AssemblyProtocol
    
    init(navController: UINavigationController, assembly: AssemblyProtocol) {
        self.navController = navController
        self.assembly = assembly
    }
    
    func initialViewController() {
        let usersListVC = assembly.createUsersListModule(router: self)
        navController.setViewControllers([usersListVC], animated: true)
    }
    
    func pushToUserDetail(searchName: String) {
        let userDetailVC = assembly.createUserDetailModule(searchName: searchName, router: self)
        navController.pushViewController(userDetailVC, animated: true)
    }
}
