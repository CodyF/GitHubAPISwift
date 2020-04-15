//
//  APIService.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/14/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

typealias UserInfoHandler = (_ result: Result<[UserInfo], ErrorInfo>) -> Void
typealias RepoHandler = (_ result: Result<[repoModel], ErrorInfo>) -> Void

struct ErrorInfo: Error {
    var errorDescription: String?
}

protocol userService {
    func getUsers(_ searchTerm: String, completion: @escaping UserInfoHandler)
}

class UsersSearch: userService {
    func getUsers(_ searchTerm: String, completion: @escaping UserInfoHandler) {
        guard let url = GitAPI(searchTerm).userURL else {
            completion(.failure(.init(errorDescription: "Bad URL")))
            return
        }
        //TODO: Convert to NSOperations
        var users = [Users]()
        var userInfo = [UserInfo]()
        
        //MARK: What would be a better way to do this?
        DispatchQueue.global().async {
            let group = DispatchGroup()
            group.enter()
            URLSession.shared.dataTask(with: url) { (dat, _, err) in
                if let error = err {
                    completion(.failure(.init(errorDescription: error.localizedDescription)))
                    return
                }
                if let data = dat {
                    do {
                        let response = try JSONDecoder().decode(usersReponse.self, from: data)
                        users = response.items
                        group.leave()
                    } catch {
                        print(error)
                        completion(.failure(.init(errorDescription: error.localizedDescription)))
                        
                        return
                    }
                }
            }.resume()
            
            group.wait()
            for user in users {
                group.wait()
                group.enter()
                URLSession.shared.dataTask(with: user.url) { (dat, _, err) in
                    if let error = err {
                        completion(.failure(.init(errorDescription: error.localizedDescription)))
                        return
                    }
                    if let data = dat {
                        do {
                            let response = try JSONDecoder().decode(UserInfo.self, from: data)
                            userInfo.append(response)
                            group.leave()
                        } catch {
                            print(error)
                            completion(.failure(.init(errorDescription: error.localizedDescription)))
                            return
                        }
                    }
                    
                }.resume()
                            }
            group.wait()
            completion(.success(userInfo))
        }
    }
    func getRepos(_ url: URL, completion: @escaping RepoHandler) {
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                completion(.failure(.init(errorDescription: error.localizedDescription)))
                return
            }
            if let data = dat {
                do {
                    let response = try JSONDecoder().decode([repoModel].self, from: data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(.init(errorDescription: error.localizedDescription)))
                    return
                }
            }
        }.resume()
    }
}


