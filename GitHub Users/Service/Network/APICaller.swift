//
//  APICaller.swift
//  GitHub Users
//
//  Created by Maks Kokos on 21.11.2022.
//

import Foundation
import Alamofire

struct Constants {
    static let listOfAllUsersURL = "https://api.github.com/users"
}

final class APICaller {
    
    static let shared = APICaller()
    
    func getListOfAllUsers(searchOffset: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: Constants.listOfAllUsersURL) else {return}
        let parameters = ["per_page": 30, "since": searchOffset]
        AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: [User].self) { response in
            guard let data = response.value, response.error == nil else { return completion(.failure(response.error!)) }
            completion(.success(data))
        }
    }
    
    func getUserFromSearch(userName: String, completion: @escaping (Result<User, Error>) -> Void) {
        createDataTask(userName: userName, model: User.self, completion: completion)
    }
    
    func getUserDetail(userName: String, completion: @escaping (Result<UserDetail, Error>) -> Void) {
        createDataTask(userName: userName, model: UserDetail.self, completion: completion)
    }
    
    private func createDataTask<T: Decodable>(userName: String, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = Constants.listOfAllUsersURL + "/\(userName)"
        guard let url = URL(string: urlString) else { return }
        AF.request(url, method: .get).validate().responseDecodable(of: model.self) { response in
            guard let data = response.value, response.error == nil else { return completion(.failure(response.error!)) }
            completion(.success(data))
        }
    }
}
