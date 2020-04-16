//
//  UserResponseModel.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

struct Users: Codable {
    let users: [User]
    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}
