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
    
    func getListOfAllUsers(searchOffset: Int = 0, completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: Constants.listOfAllUsersURL) else {return}
        let parameters = ["per_page": 30, "since": searchOffset]
        AF.request(url, method: .get, parameters: parameters).responseData { response in
            guard response.error == nil, let response = response.data else { return }
            do {
                let results = try JSONDecoder().decode([User].self, from: response)
                completion(.success(results))
            } catch let error {
                completion(.failure(error))
            }
        }
    }

}


