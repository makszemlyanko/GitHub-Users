//
//  Users.swift
//  GitHub Users
//
//  Created by Maks Kokos on 21.11.2022.
//

import Foundation


struct User: Decodable {
    let login: String
    let avatar_url: String
}
