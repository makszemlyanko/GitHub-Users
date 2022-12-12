//
//  UsersListPresenter.swift
//  GitHub Users
//
//  Created by Maks Kokos on 29.11.2022.
//

import Foundation

protocol UsersListProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol UsersListPresenterProtocol {
    var users: [User]? { get set }
    var fetchMoreUsers: Bool { get set }
    func getUsersList()
    func getNextPageWithUsers()
    func didTapOnUserCell(searchName: String)
}

final class UsersListPresenter: UsersListPresenterProtocol {
    
    weak var view: UsersListProtocol?
    var users: [User]?
    let router: RouterProtocol
    var pagination = 0
    var fetchMoreUsers = false
    
    init(view: UsersListProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        getUsersList()
    }
    
    func getUsersList() {
        Network.shared.getListOfAllUsers(with: self.pagination) { [weak self] response in
            DispatchQueue.main.async {
                switch response {
                case .success(let users):
                    self?.users = users
                    self?.pagination = users.last?.id ?? 0
                    
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    
    func getNextPageWithUsers() {
        Network.shared.getListOfAllUsers(with: self.pagination) { [weak self] response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                switch response {
                case .success(let nextUsersPage):
                    self?.users? += nextUsersPage
                    self?.pagination = nextUsersPage.last?.id ?? 30
                    self?.fetchMoreUsers = false
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    
    func didTapOnUserCell(searchName: String) {
        router.pushToUserDetail(searchName: searchName)
    }
}
