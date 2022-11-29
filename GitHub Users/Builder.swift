//
//  Builder.swift
//  GitHub Users
//
//  Created by Maks Kokos on 29.11.2022.
//

import UIKit

protocol BuilderProtocol {
    func createUsersListModule(router: RouterProtocol) -> UIViewController
    func createUserDetailModule(searchName: String ,router: RouterProtocol) -> UIViewController
}

final class Builder: BuilderProtocol {

    func createUsersListModule(router: RouterProtocol) -> UIViewController {
        let view = UsersListViewController()
        let presenter = UsersListPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    func createUserDetailModule(searchName: String ,router: RouterProtocol) -> UIViewController {
        let view = UserDetailViewController()
        let presenter = UserDetailPresenter(view: view, searchName: searchName, router: router)
    
//        view.userSearchName = searchName
        view.presenter = presenter
        return view
    }
}
