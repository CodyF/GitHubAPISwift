//
//  RepoService.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

typealias RepoHandler = (_ result: Result<[Repo], ErrorInfo>) -> Void

protocol RepoService: class {
    func getRepos(_ url: URL, completion: @escaping RepoHandler)
}

class RepoSearch: RepoService {
    func getRepos(_ url: URL, completion: @escaping RepoHandler) {
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                completion(.failure(.init(errorDescription: error.localizedDescription)))
                return
            }
            if let data = dat {
                do {
                    let response = try JSONDecoder().decode([Repo].self, from: data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(.init(errorDescription: error.localizedDescription)))
                    return
                }
            }
        }.resume()
    }
}
