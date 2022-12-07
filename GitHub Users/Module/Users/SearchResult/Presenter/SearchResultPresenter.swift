//
//  SearchResultPresenter.swift
//  GitHub Users
//
//  Created by Maks Kokos on 01.12.2022.
//

import Foundation

protocol SearchResultProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol SearchResultPresenterProtocol {
    var user: User? { get set }
    func getUserFromSearch(searchQuery: String)
}

final class SearchResultPresenter: SearchResultPresenterProtocol {
    
    weak var view: SearchResultProtocol?
    var user: User?
    
    init(view: SearchResultProtocol?) {
        self.view = view
    }
    
    func getUserFromSearch(searchQuery: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            Network.shared.getUserFromSearch(for: searchQuery) { result in
                switch result {
                case .success(let user):
                    self?.user = user
                case .failure(let error):
                    self?.user = nil
                    self?.view?.failure(error: error)
                }
                self?.view?.success()
            }
        }
    }
}
