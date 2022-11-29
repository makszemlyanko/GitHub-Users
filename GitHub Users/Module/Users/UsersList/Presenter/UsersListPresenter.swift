//
//  UsersListPresenter.swift
//  GitHub Users
//
//  Created by Maks Kokos on 29.11.2022.
//

import Foundation

protocol UsersListProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol UsersListPresenterProtocol {
    var users: [User]? { get set }
    var searchOffset: Int { get set }
    var fetchMoreUsers: Bool { get set }
    init(view: UsersListProtocol, router: RouterProtocol)
    func getUsersList()
    func getNextPageWithUsers()
    func didTapOnUserCell(searchName: String)
}

final class UsersListPresenter: UsersListPresenterProtocol {
   
    var users: [User]?
    
    weak var view: UsersListProtocol?
    
    var router: RouterProtocol
    
    var searchOffset = 0
    
    var fetchMoreUsers = false
    
    init(view: UsersListProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        getUsersList()
    }
    
    func getUsersList() {
        DispatchQueue.main.async {
            APICaller.shared.getListOfAllUsers(searchOffset: self.searchOffset) { [weak self] response in
                switch response {
                case .success(let users):
                    self?.users = users
                    self?.searchOffset = users.last?.id ?? 0
                    self?.view?.succes()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
    
    func getNextPageWithUsers() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            APICaller.shared.getListOfAllUsers(searchOffset: self?.searchOffset ?? 0) { response in
                switch response {
                case .success(let nextUsersPage):
                    self?.users? += nextUsersPage
                    self?.searchOffset = nextUsersPage.last?.id ?? 30
                    self?.fetchMoreUsers = false
                    self?.view?.succes()
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

