//
//  StudentRequest.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/3/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import Foundation

struct StudentRequest: Codable {
    let results:[Student]
}

enum OptionalQuery: String {
    case limit = "?limit="
    case orderByUpdatedAt = "?order=-updatedAt"
}
