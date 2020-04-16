//
//  RepositoryModel.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/14/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

struct Repo: Codable {
    let name: String
    let url: URL
    let stars: Int
    let forks: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case stars = "stargazers_count"
        case forks
    }
}
