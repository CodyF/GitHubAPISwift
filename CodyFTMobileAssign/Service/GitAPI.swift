//
//  APICalls.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/14/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

class GitAPI {
    var user: String!
    let userSearch = "https://api.github.com/search/users?q="
    init(_ term: String) {
        self.user = term
    }
    var userURL: URL? {
        return URL(string: userSearch + user)
    }
}
