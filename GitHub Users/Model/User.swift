//
//  User.swift
//  GitHub Users
//
//  Created by Maks Kokos on 22.11.2022.
//

import Foundation

struct User: Hashable {
    let login: String
    let id: Int
    let avatarURL: String
}

extension User: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case login
        case id
        case avatarURL = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        login = try container.decode(String.self, forKey: .login)
        id = try container.decode(Int.self, forKey: .id)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
    }
}
