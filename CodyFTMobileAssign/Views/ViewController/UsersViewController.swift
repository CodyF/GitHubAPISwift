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
        viewModel.updateClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.userTableView.reloadData()
            }
        }
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Users"
        navigationItem.searchController = searchController
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
        let viewModel = (tableView.cellForRow(at: indexPath) as? UserTableCell)?.viewModel
        vc.userInfoViewModel = viewModel
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
        viewModel.infoViewModel(for: indexPath.row) { result in
            cell.viewModel = result
        }
        return cell
    }
    
    
}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            guard let search = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
            self?.viewModel.getUsers(search)
        })
    }
}
