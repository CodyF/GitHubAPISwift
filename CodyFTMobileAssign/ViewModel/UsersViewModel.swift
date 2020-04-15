//
//  MainViewModel.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

//MARK: This View Model is for setting up the users view controller
protocol usersDelegate: class {
    func reload()
}
protocol usersProtocol {
    var navigationTitle: String { get }
    var delegate: usersDelegate? { get set }
}

class usersViewModel: usersProtocol {
    var service: userService!
    weak var delegate: usersDelegate?
    var users = [UserInfo]() {
        didSet {
            self.delegate?.reload()
        }
    }
    var navigationTitle: String {
        return "GitHub Searcher"
    }
    init(service: userService = UsersSearch()) {
        self.service = service
    }
    func numberOfRows() -> Int {
        return users.count
    }

    func getUsers(_ term: String) {
        service.getUsers(term) { [weak self] (result) in
            switch result {
            case .success(let Users):
                let userData = Users
                self?.users = userData
            case .failure(let error):
                print(error)
            }
        }
    }
}
