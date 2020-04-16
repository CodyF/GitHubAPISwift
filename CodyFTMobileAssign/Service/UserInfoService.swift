//
//  UserInfoService.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import Foundation

typealias UserInfoHandler = (_ result: Result<UserInfo, ErrorInfo>) -> Void

protocol UserInfoService: class {
    func getUserInfo(_ url: URL, completion: @escaping UserInfoHandler)
}

class UserInfoSearch: UserInfoService {
    func getUserInfo(_ url: URL, completion: @escaping UserInfoHandler) {
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                completion(.failure(.init(errorDescription: error.localizedDescription)))
                return
            }
            if let data = dat {
                do {
                    let response = try JSONDecoder().decode(UserInfo.self, from: data)
                    completion(.success(response))
                } catch {
                    print(error)
                    completion(.failure(.init(errorDescription: error.localizedDescription)))
                    return
                }
            }
        }.resume()
    }
}
