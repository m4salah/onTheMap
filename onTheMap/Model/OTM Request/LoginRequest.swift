//
//  LoginRequest.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/3/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let udacity: Udacity
}

struct Udacity: Codable {
    let username: String
    let password: String
}
