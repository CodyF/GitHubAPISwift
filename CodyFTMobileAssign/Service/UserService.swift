//
//  APIService.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/14/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

typealias UserHandler = (_ result: Result<[User], ErrorInfo>) -> Void

struct ErrorInfo: Error {
    var errorDescription: String?
}

protocol UserService {
    func getUsers(_ searchTerm: String, completion: @escaping UserHandler)
}

class UsersSearch: UserService {
    func getUsers(_ searchTerm: String, completion: @escaping UserHandler) {
        guard let url = GitAPI(searchTerm).userURL else {
            completion(.failure(.init(errorDescription: "Bad URL")))
            return
        }
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                completion(.failure(.init(errorDescription: error.localizedDescription)))
                return
            }
            if let data = dat {
                do {
                    let response = try JSONDecoder().decode(Users.self, from: data)
                    completion(.success(response.users))
                } catch {
                    print(error)
                    completion(.failure(.init(errorDescription: error.localizedDescription)))
                    return
                }
            }
        }.resume()
    }
}

