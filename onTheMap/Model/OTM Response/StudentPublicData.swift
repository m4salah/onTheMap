//
//  StudentPublicData.swift
//  onTheMap
//
//  Created by Mohamed Abdelkhalek Salah on 5/4/20.
//  Copyright © 2020 Mohamed Abdelkhalek Salah. All rights reserved.
//

import Foundation

struct StudentPublicData: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
