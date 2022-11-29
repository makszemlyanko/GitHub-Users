//
//  UserDetail.swift
//  GitHub Users
//
//  Created by Maks Kokos on 23.11.2022.
//

import Foundation

struct UserDetail {
    let login: String?
    let avatarURL: String
    let name: String?
    let company: String?
    let location: String?
    let email: String?
    let followers: Int
    let following: Int
    let createdAt: String
    let htmlUrl: String
}

extension UserDetail: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case name
        case company
        case location
        case email
        case followers
        case following
        case createdAt = "created_at"
        case htmlUrl = "html_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        login = try container.decode(String.self, forKey: .login)
        avatarURL = try container.decode(String.self, forKey: .avatarURL)
        name = try? container.decode(String.self, forKey: .name)
        company = try? container.decode(String.self, forKey: .company)
        location = try? container.decode(String.self, forKey: .location)
        email = try? container.decode(String.self, forKey: .email)
        followers = try container.decode(Int.self, forKey: .followers)
        following = try container.decode(Int.self, forKey: .following)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        htmlUrl = try container.decode(String.self, forKey: .htmlUrl)
    }
}
