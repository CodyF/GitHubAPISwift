//
//  MainViewModel.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation


protocol UsersProtocol {
    var navigationTitle: String { get }
}

class usersViewModel: UsersProtocol {
    var userService: UserService
    var userInfoService: UserInfoService
    var updateClosure: (() -> Void)?
    var user = [User]() {
        didSet {
            self.updateClosure?()
        }
    }
    var navigationTitle: String {
        return "GitHub Searcher"
    }
    init(userService: UserService = UsersSearch(), userInfoService: UserInfoService = UserInfoSearch()) {
        self.userService = userService
        self.userInfoService = userInfoService
    }
    func numberOfRows() -> Int {
        return user.count
    }

    func getUsers(_ term: String) {
        userService.getUsers(term) { [weak self] (result) in
            switch result {
            case .success(let users):
                let userData = users
                self?.user = userData
            case .failure(let error):
                print(error)
            }
        }
    }
    func infoViewModel(for index: Int, completion: @escaping (UserInfoViewModel?) -> Void) {
        userInfoService.getUserInfo(user[index].url) { result in
            switch result {
            case .success(let userInfo):
                let userInfoViewModel = UserInfoViewModel(userInfo)
                completion(userInfoViewModel)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
}
