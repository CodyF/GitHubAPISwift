//
//  UserModel.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/14/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

struct usersReponse: Codable {
    let items: [Users]
}

struct Users: Codable {
    let url: URL

}
//MARK: Should I put these in a seperate file?
struct UserInfo: Codable{
    let login: String
    let avatarURL: URL
    let reposURL: URL
    let location: String?
    let email: String?
    let bio: String?
    let publicRepos: Int
    let followers: Int
    let following: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarURL = "avatar_url"
        case reposURL = "repos_url"
        case location, email, bio
        case publicRepos = "public_repos"
        case followers, following
        case createdAt = "created_at"
    }
}
