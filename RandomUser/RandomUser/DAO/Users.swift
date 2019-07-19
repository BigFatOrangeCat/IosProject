//
//  Users.swift
//  RandomUser
//
//  Created by jichenjiang on 2019/7/19.
//  Copyright © 2019 jichenjiang. All rights reserved.
//

import Foundation

struct RandomUser: Codable {
    let results: [UserDetail]
}

struct UserDetail: Codable {
    let gender: String
    let email: String
    let phone: String
    let cell: String
    let name: UserName
    let picture: Pictures
    let location: Address
}

struct UserName: Codable {
    let title: String
    let first: String
    let last: String
}

struct Pictures: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct Address: Codable {
    let street: String
    let city: String
    let state: String
}
