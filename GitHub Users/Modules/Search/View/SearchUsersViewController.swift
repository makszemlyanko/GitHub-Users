//
//  SearchUsersViewController.swift
//  GitHub Users
//
//  Created by Maks Kokos on 18.11.2022.
//

import UIKit
import Kingfisher

final class SearchUsersViewController: UIViewController {
    
    var users = [User]()
    
    private let usersTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.backgroundDarkGray
        table.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.cellId)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Search Users"
        controller.searchBar.barStyle = .black
        controller.searchBar.searchTextField.leftView?.tintColor = .accentGreen
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        APICaller.shared.getUsers { [weak self] response in
            
            switch response {
            case .success(let results):
                self?.users = results
                DispatchQueue.main.async {
                    self?.usersTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    
        addNavBarImage()
        
        setupSearchBar()
        
        
        
        
        view.addSubview(usersTableView)
        usersTableView.dataSource = self
        usersTableView.delegate = self
        
//        addNavBarImage()
        
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
        navigationItem.hidesSearchBarWhenScrolling = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
    }
    

    

}

extension SearchUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellId, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        
        
        cell.nameLabel.text = self.users[indexPath.row].login
        let imageURL = URL(string: self.users[indexPath.row].avatar_url)
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
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchUsersViewController: UISearchBarDelegate {

}
