//
//  UserViewController.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/14/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import UIKit
import SafariServices

class UserInfoViewController: UIViewController {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var repoTableView: UITableView!
    
    var user: UserInfo!
    var repoViewModel = RepoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupUsers() {
        self.title = "GitHub Searcher"
        user.avatarURL.downloadImage { [weak self] (result) in
            self?.avatarImage.image = result
        }
        usernameLabel.text = user.login
        emailLabel.text = user.email ?? "No Email Available"
        locationLabel.text = user.location ?? "No Location Available"
        let dateFormatter = ISO8601DateFormatter()
        let readableDate = dateFormatter.date(from: user.createdAt)
        dateFormatter.formatOptions = .withDashSeparatorInDate
        joinDateLabel.text = dateFormatter.string(from: readableDate!)
        followersLabel.text = "\(user.followers) Followers"
        followingLabel.text = "Following\(user.following)"
        bioLabel.text = user.bio ?? "No Bio Available"
        repoViewModel.delegate = self
        repoViewModel.getRepos(user.reposURL)
    }
}

extension UserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let SafariVC = SFSafariViewController(url: repoViewModel.repos[indexPath.row].url)
        navigationController?.pushViewController(SafariVC, animated: true)
        
    }
}

extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoViewModel.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableCell", for: indexPath) as! RepoTableCell
        cell.repos = repoViewModel.repos[indexPath.row]
        return cell
    }
}

extension UserInfoViewController: RepoDelegate{
    func reload() {
        self.repoTableView.reloadData()
    }
}
