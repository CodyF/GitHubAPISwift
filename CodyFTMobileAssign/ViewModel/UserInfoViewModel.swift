//
//  UserInfoViewModel.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

class UserInfoViewModel {
    lazy var dateFormatter: ISO8601DateFormatter = ISO8601DateFormatter()
    private let userInfo: UserInfo
    
    init(_ userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
    var username: String {
        return userInfo.login
    }
    
    var avatarURL: URL {
        return userInfo.avatarURL
    }
    
    var reposURL: URL {
        return userInfo.reposURL
    }
    
    var repoCount: Int {
        return userInfo.publicRepos
    }
    
    var email: String? {
        return userInfo.email
    }
    
    var bio: String? {
        return userInfo.bio
    }
    
    var location: String? {
        return userInfo.location
    }
    
    var followers: Int {
        return userInfo.followers
    }
    
    var following: Int {
        return userInfo.following
    }
    
    var date: String? {
        guard let readableDate = dateFormatter.date(from: userInfo.createdAt) else {return nil}
        dateFormatter.formatOptions = .withDashSeparatorInDate
        return dateFormatter.string(from: readableDate)
    }
}
