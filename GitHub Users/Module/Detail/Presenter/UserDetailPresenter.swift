//
//  UserDetailPresenter.swift
//  GitHub Users
//
//  Created by Maks Kokos on 29.11.2022.
//

import Foundation

protocol UserDetailProtocol: AnyObject {
    
}

protocol UserDetailPresenterProtocol {
    init(view: UserDetailProtocol, model: UserDetail?, router: RouterProtocol)
}

final class UserDetailPresenter: UserDetailPresenterProtocol {
    
    weak var view: UserDetailProtocol?
    
    var router: RouterProtocol
    
    var userDetail: UserDetail?
    
    required init(view: UserDetailProtocol, model: UserDetail?, router: RouterProtocol) {
        self.view = view
        self.userDetail = model
        self.router = router
    }
    
}
