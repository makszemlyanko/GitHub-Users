//
//  SearchUsersViewController.swift
//  GitHub Users
//
//  Created by Maks Kokos on 18.11.2022.
//

import UIKit
import Kingfisher

final class SearchUsersViewController: UIViewController, UISearchControllerDelegate {
    
    
 
    private let floatingUpButton: UIButton = {
        let button = UIButton(frame: .init(x: 0, y: 0, width: 60, height: 60))
        button.layer.cornerRadius = 22
        button.backgroundColor = .accentGreen
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.5
        let image = UIImage(systemName: "arrow.up", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapUpButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapUpButton() {
//        let indexPath = IndexPath(row: NSNotFound, section: 0)
//        usersTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
            
        let indexPath = IndexPath(row: NSNotFound, section: 0)
        usersTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)

    }
    
    
    
    
    //////////////////
    private var searchOffset = 0
    private var fetchMoreUsers = false
    
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.tintColor = .accentGreen
        rc.backgroundColor = .backgroundCustomBlack
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.accentGreen]
        rc.attributedTitle = NSAttributedString(string: "Refreshing", attributes: attributes)
        rc.addTarget(self, action: #selector(pullToRefreshList), for: .valueChanged)
        return rc
    }()
    
    var users = [User]()
    
    
    private let usersTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .backgroundDarkGray
        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.cellId)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search by user login"
        controller.searchBar.barStyle = .black
        controller.searchBar.tintColor = .accentGreen
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.searchTextField.leftView?.tintColor = .accentGreen
        controller.searchBar.searchTextField.textColor = .white
        return controller
    }()
    
    @objc func pullToRefreshList(sender: UIRefreshControl) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.users.shuffle()
            self.usersTableView.reloadData()
        })
        sender.endRefreshing()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        getAllUsersList()
        
        
        
        
        self.usersTableView.refreshControl = self.refreshControl
        setupSearchBar()
        view.addSubview(usersTableView)
        
        
        
        usersTableView.dataSource = self
        usersTableView.delegate = self
        

        
        navigationController?.navigationBar.tintColor = .accentGreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        floatingUpButton.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 70, width: 44, height: 44)
    }
    

    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usersTableView.frame = view.bounds
    }
    

    
    private func getAllUsersList() {
        APICaller.shared.getListOfAllUsers(searchOffset: self.searchOffset) { [weak self] response in
            switch response {
            case .success(let results):
                self?.users = results
                self?.searchOffset = results.last?.id ?? 0
                DispatchQueue.main.async {
                    self?.usersTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func setupSearchBar() {
        navigationItem.title = "Users"
        usersTableView.tableHeaderView = searchController.searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        self.searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
    }
    
    

    
    private func createSpinnerForFooter() -> UIView {
        let footerView = UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 120))
        let spinner = UIActivityIndicatorView()
        spinner.center.x = footerView.center.x
        spinner.center.y = footerView.center.y
        spinner.color = .accentGreen
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    

    

    

}

extension SearchUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellId, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        cell.loginLabel.text = self.users[indexPath.row].login
        cell.idLabel.text = "Id: \(self.users[indexPath.row].id)"
        let imageURL = URL(string: self.users[indexPath.row].avatarURL)
        cell.avatarImage.kf.setImage(with: imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension SearchUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UserDetailViewController()
        let userName = users[indexPath.row].login
        detailVC.userSearchName = userName
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        
        // floating button
        if offsetY <= -48 {
            floatingUpButton.removeFromSuperview()
        } else {
            view.addSubview(floatingUpButton)
        }
        
        
        // network
        if offsetY > contentHeight - scrollView.frame.height {
            if !self.fetchMoreUsers {
                self.fetchMoreUsers = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.usersTableView.tableFooterView = self.createSpinnerForFooter()
                    APICaller.shared.getListOfAllUsers(searchOffset: self.searchOffset) { [weak self] response in
                        switch response {
                        case .success(let nextUsersPage):
                            self?.users += nextUsersPage
                            self?.searchOffset = nextUsersPage.last?.id ?? 30
                            self?.fetchMoreUsers = false
                            self?.usersTableView.reloadData()
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

extension SearchUsersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
       guard let searchQuery = searchBar.text,
              !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty,
              searchQuery.trimmingCharacters(in: .whitespaces).count >= 3,
              let searchResultController = searchController.searchResultsController as? SearchResultViewController else { return }
        
        searchResultController.delegate = self
        
        APICaller.shared.getUserFromSearch(userName: searchQuery) { result in
            switch result {
            case .success(let user):
                searchResultController.users.removeAll()
                searchResultController.users.insert(user, at: 0)
                DispatchQueue.main.async {
                    searchResultController.searchUserTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                // nothing found
            }
        }
        
    }
    
    
}

extension SearchUsersViewController: SearchResultViewControllerDelegate {
    func showUserDetail(userName: String) {
        let detailVC = UserDetailViewController()
        detailVC.userSearchName = userName
        navigationController?.pushViewController(detailVC, animated: true)
    } 
}
 
