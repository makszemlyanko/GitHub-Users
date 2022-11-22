//
//  UserDetail.swift
//  GitHub Users
//
//  Created by Maks Kokos on 22.11.2022.
//

import Foundation

struct UserDetail: Decodable {
    let name: String
    let avatar_url: String
    let company: String?
    let location: String?
    let email: String?
    let followers: Int
    let following: Int
    let created_at: Date
}
