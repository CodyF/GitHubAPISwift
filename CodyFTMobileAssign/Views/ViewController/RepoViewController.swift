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
    
    
    var userInfoViewModel: UserInfoViewModel!
    var repoViewModel = RepoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUsers()
    }

    func setupUsers() {
        self.title = "GitHub Searcher"
        userInfoViewModel.avatarURL.downloadImage { [weak self] (result) in
            self?.avatarImage.image = result
        }
        usernameLabel.text = userInfoViewModel.username
        emailLabel.text = userInfoViewModel.email ?? "No Email Available"
        locationLabel.text = userInfoViewModel.location ?? "No Location Available"
        joinDateLabel.text = userInfoViewModel.date
        followersLabel.text = "\(userInfoViewModel.followers) Followers"
        followingLabel.text = "Following\(userInfoViewModel.following)"
        bioLabel.text = userInfoViewModel.bio ?? "No Bio Available"
        repoViewModel.updateClosure = { [weak self] in
                DispatchQueue.main.async {
                self?.repoTableView.reloadData()
            }
        }
        repoViewModel.getRepos(userInfoViewModel.reposURL)
    }
}

extension UserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let SafariVC = SFSafariViewController(url: repoViewModel.getURL(indexPath.row))
        navigationController?.pushViewController(SafariVC, animated: true)
        
    }
}

extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableCell", for: indexPath) as! RepoTableCell
        cell.repoLabel.text = repoViewModel.repoName(indexPath.row)
        cell.forkLabel.text = "\(repoViewModel.numberOfForks(indexPath.row)) Forks"
        cell.starLabel.text = "\(repoViewModel.numberOfStars(indexPath.row)) Stars"
        return cell
    }
}

extension UserInfoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        repoViewModel.filterReposBySearch(searchText)
    }
}
