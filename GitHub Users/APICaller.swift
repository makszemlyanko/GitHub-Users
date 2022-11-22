//
//  APICaller.swift
//  GitHub Users
//
//  Created by Maks Kokos on 21.11.2022.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users") else {return}
        
        createDataTask(url: url, completion: completion)
    
    
    
    
    
 
}
    
    private func createDataTask(url: URL, completion: @escaping (Result<[User], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return  }
            do {
                let results = try JSONDecoder().decode([User].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error.localizedDescription as! Error))
            }
        }
        task.resume()
    }

}
