//
//  UserDetailPresenter.swift
//  GitHub Users
//
//  Created by Maks Kokos on 29.11.2022.
//

import Foundation

protocol UserDetailProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol UserDetailPresenterProtocol {
    var userDetail: UserDetail? { get set }
    func getUserDetail()
}

final class UserDetailPresenter: UserDetailPresenterProtocol {
    
    weak var view: UserDetailProtocol?
    var router: RouterProtocol
    var userDetail: UserDetail?
    var userSearchName: String?
    
    required init(view: UserDetailProtocol, searchName: String, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.userSearchName = searchName
        getUserDetail()
    }
    
    func getUserDetail() {
        Network.shared.getUserDetail(for: self.userSearchName ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.userDetail = user
                    self?.view?.success()
                case .failure(let error):
                    self?.view?.failure(error: error)
                }
            }
        }
    }
}
