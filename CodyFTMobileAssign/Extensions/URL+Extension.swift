//
//  URL+Extension.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import UIKit

typealias ImageHandler = (UIImage?) -> Void

extension URL {
    
    func downloadImage(completion: @escaping ImageHandler) {
        URLSession.shared.dataTask(with: self) { (dat, _, _) in
            if let data = dat {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }.resume()
    }
    
}
