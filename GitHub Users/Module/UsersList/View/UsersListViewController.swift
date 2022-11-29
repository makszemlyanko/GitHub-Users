//
//  UsersListViewController.swift
//  GitHub Users
//
//  Created by Maks Kokos on 18.11.2022.
//

import UIKit
import Kingfisher

final class UsersListViewController: UIViewController {
    
    var presenter: UsersListPresenterProtocol!
    
    private let usersTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .backgroundDarkGray
        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.cellId)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Enter username"
        controller.searchBar.barStyle = .black
        controller.searchBar.tintColor = .accentGreen
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.searchTextField.leftView?.tintColor = .accentGreen
        controller.searchBar.searchTextField.textColor = .white
        controller.hidesNavigationBarDuringPresentation = false
        return controller
    }()
    
    private lazy var returnToTopButton: UIButton = {
        let button = UIButton(frame: .init(x: 0, y: 0, width: 60, height: 60))
        let image = UIImage(systemName: "arrow.up", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        button.layer.cornerRadius = 22
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.5
        button.setImage(image, for: .normal)
        button.backgroundColor = .accentGreen
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapUpButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapUpButton() {
        let indexPath = IndexPath(row: NSNotFound, section: 0)
        usersTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.accentGreen]
        rc.tintColor = .accentGreen
        rc.backgroundColor = .backgroundCustomBlack
        rc.attributedTitle = NSAttributedString(string: "Refreshing", attributes: attributes)
        rc.addTarget(self, action: #selector(pullToRefreshList), for: .valueChanged)
        return rc
    }()
    
    @objc func pullToRefreshList(sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            self?.presenter.users?.shuffle()
            self?.usersTableView.reloadData()
        })
        sender.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUsersTableView()
        configureNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usersTableView.frame = view.bounds
        usersTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        returnToTopButton.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 70, width: 44, height: 44)
    }
    
    private func configureUsersTableView() {
        view.addSubview(usersTableView)
        usersTableView.refreshControl = self.refreshControl
        usersTableView.dataSource = self
        usersTableView.delegate = self
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Search"
        navigationItem.titleView = searchController.searchBar
        navigationController?.navigationBar.tintColor = .accentGreen
        definesPresentationContext = true
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

extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellId, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        cell.userLogin.text = presenter.users?[indexPath.row].login
        cell.userId.text = "# \(presenter.users?[indexPath.row].id ?? 0)"
        let imageURL = URL(string: presenter.users?[indexPath.row].avatarURL ?? "")
        cell.userAvatar.kf.setImage(with: imageURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userName = presenter.users?[indexPath.row].login ?? ""
        presenter.didTapOnUserCell(searchName: userName)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY <= -48 {
            self.returnToTopButton.removeFromSuperview()
        } else {
            view.addSubview(self.returnToTopButton)
        }
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !presenter.fetchMoreUsers {
                presenter.fetchMoreUsers = true
                self.usersTableView.tableFooterView = self.createSpinnerForFooter()
                self.presenter.getNextPageWithUsers()
                self.succes()
            }
        }
    }
}

extension UsersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchQuery = searchBar.text,
              !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty,
              searchQuery.trimmingCharacters(in: .whitespaces).count >= 3,
              let searchResultController = searchController.searchResultsController as? SearchResultViewController else { return }
        
        searchResultController.delegate = self
        
        #warning("need presenter")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            APICaller.shared.getUserFromSearch(userName: searchQuery) { result in
                switch result {
                case .success(let user):
                    searchResultController.user = user
                    
                    searchResultController.searchUserTableView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    searchResultController.user = nil
                }
            }
        }
        
        
        

    }
}

extension UsersListViewController: SearchResultViewControllerDelegate {
    func showUserDetail(userName: String) {
        presenter.didTapOnUserCell(searchName: userName)
    } 
}

extension UsersListViewController: UsersListProtocol {
    func succes() {
        usersTableView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
