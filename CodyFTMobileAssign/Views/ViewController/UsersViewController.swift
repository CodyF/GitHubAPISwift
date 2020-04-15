//
//  ViewController.swift
//  CodyFTMobileAssign
//
//  Created by Consultant on 4/14/20.
//  Copyright © 2020 consultant. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var userTableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    var timer: Timer? = nil

    var viewModel = usersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUsers()
    }
    
    func setupUsers() {
        
        self.title = viewModel.navigationTitle
        viewModel.delegate = self
        searchController.searchBar.delegate = self
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Users"
        navigationItem.searchController = searchController
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
        let user = viewModel.users[indexPath.row]
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as! UserTableCell
        cell.user = viewModel.users[indexPath.row]
        return cell
    }
    
    
}

extension UsersViewController: usersDelegate {
    func reload() {
        DispatchQueue.main.async {
            self.userTableView.reloadData()
        }
    }
}
extension UsersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        viewModel.getUsers(search)
    }
}
//extension UsersViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        timer?.invalidate()
//        let searchBar = searchController.searchBar
//        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] (timer) in
//            self?.viewModel.getUsers(searchBar.text!)
//        }
//
//    }
//}
