//
//  TableViewCell.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    
    var viewModel: UserInfoViewModel! {
        didSet {
            DispatchQueue.main.async {
                self.viewModel.avatarURL.downloadImage { [weak self] result in
                self?.avatarImage.image = result
            }
                self.usernameLabel.text = self.viewModel.username
                self.repoLabel.text = "Repos: \(self.viewModel.repoCount)"
            }
        }
    }
}
