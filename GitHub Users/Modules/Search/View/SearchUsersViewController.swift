//
//  SearchUsersViewController.swift
//  GitHub Users
//
//  Created by Maks Kokos on 18.11.2022.
//

import UIKit

final class SearchUsersViewController: UIViewController {
    
    private let usersTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.backgroundDarkGray
        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.cellId)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search Users"
        controller.searchBar.searchBarStyle = .minimal
        controller.obscuresBackgroundDuringPresentation = false
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        
        
        view.addSubview(usersTableView)
        usersTableView.dataSource = self
        usersTableView.delegate = self
        
        addNavBarImage()
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .accentGreen
        
        navigationController?.navigationBar.barTintColor = .backgroundDarkGray
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usersTableView.frame = view.bounds
    }
    
    private func addNavBarImage() {
        let navController = navigationController!
        let image = UIImage(named: "title")
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.searchController?.searchBar.tintColor = .accentGreen
        navigationItem.searchController?.searchBar.barTintColor = .backgroundCustomBlack
        self.searchController.searchBar.delegate = self
    }
    
    

}

extension SearchUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellId, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension SearchUsersViewController: UITableViewDelegate {
    
}

extension SearchUsersViewController: UISearchBarDelegate {
    
}
