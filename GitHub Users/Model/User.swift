//
//  User.swift
//  GitHub Users
//
//  Created by Maks Kokos on 22.11.2022.
//

import Foundation

struct User: Decodable {
    let login: String
    let id: Int
    let avatar_url: String
}
