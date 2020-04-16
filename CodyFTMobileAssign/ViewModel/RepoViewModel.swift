//
//  UserViewModel.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

class RepoViewModel {
    
    var updateClosure: (() -> Void)?
    var service = RepoSearch()
    private var repos = [Repo]() {
        didSet {
            self.updateClosure?()
        }
    }
    private var allRepos = [Repo]()
    
    func numberOfRows() -> Int {
        return repos.count
    }
    
    func getRepos(_ url: URL) {
        service.getRepos(url) { [weak self] (result) in
            switch result {
            case .success(let reposData):
                self?.allRepos = reposData
                self?.repos = reposData
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func repoName(_ index: Int) -> String {
        return repos[index].name
    }
    
    func numberOfForks(_ index: Int) -> Int {
        return repos[index].forks
    }
    
    func numberOfStars(_ index: Int) -> Int {
        return repos[index].stars
    }
    
    func getURL(_ index: Int) -> URL {
        return repos[index].url
    }
    
    func filterReposBySearch(_ search: String) {
        guard !search.isEmpty else { self.repos = allRepos; return }
        let filteredRepos = allRepos.filter { $0.name.contains(search) }
        self.repos = filteredRepos
    }
}
