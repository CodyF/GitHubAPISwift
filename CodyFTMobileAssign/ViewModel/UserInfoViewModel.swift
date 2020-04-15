//
//  UserViewModel.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

protocol RepoDelegate: class {
    func reload()
}

class RepoViewModel {
    
    weak var delegate: RepoDelegate?
    var service = UsersSearch()
    var repos = [repoModel]() {
        didSet {
            self.delegate?.reload()
        }
    }
    func numberOfRows() -> Int {
        return repos.count
    }
    
    func getRepos(_ url: URL) {
        service.getRepos(url) { [weak self] (result) in
            switch result {
            case .success(let reposData):
                self?.repos = reposData
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
