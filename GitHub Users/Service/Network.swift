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

final class Network {
    
    static let shared = Network()
    
    func getListOfAllUsers(with pagination: Int, completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: Constants.listOfAllUsersURL) else {return}
        let parameters = ["per_page": 30, "since": pagination]
        createDataTask(url: url, parameters: parameters, completion: completion)
    }
    
    func getUserFromSearch(for userName: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: Constants.listOfAllUsersURL + "/\(userName)") else { return }
        createDataTask(url: url, parameters: nil, completion: completion)
    }
    
    func getUserDetail(for userName: String, completion: @escaping (Result<UserDetail, Error>) -> Void) {
        guard let url = URL(string: Constants.listOfAllUsersURL + "/\(userName)") else { return }
        createDataTask(url: url, parameters: nil, completion: completion)
    }
    
    private func createDataTask<T: Decodable>(url: URL, parameters: [String: Int]?, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of: T.self) { response in
            guard let data = response.value, response.error == nil else { return completion(.failure(response.error!)) }
            completion(.success(data))
        }
    }
}
