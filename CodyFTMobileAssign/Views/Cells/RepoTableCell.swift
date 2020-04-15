//
//  RepoTableCell.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/15/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import UIKit

class RepoTableCell: UITableViewCell {
    @IBOutlet weak var repoLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    var repos: repoModel! {
        didSet {
            repoLabel.text = repos.name
            forkLabel.text = "\(repos.forks) forks"
            starLabel.text = "\(repos.stars) stars"
        }
    }
}
