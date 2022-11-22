//
//  SearchUsersViewController.swift
//  GitHub Users
//
//  Created by Maks Kokos on 18.11.2022.
//

import UIKit
import Kingfisher

final class SearchUsersViewController: UIViewController, UISearchControllerDelegate {
    
    private var searchOffset = 0
    private var isPaginating = false
    
    private var timer: Timer?
    
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
        
        APICaller.shared.getListOfAllUsers { [weak self] response in
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
        

        
        navigationItem.searchController = self.searchController
        navigationController?.navigationBar.tintColor = .accentGreen
        
        navigationController?.navigationBar.barTintColor = .backgroundDarkGray
        


    }
    
    @objc func pullToRefreshList() {
        print("refresh")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usersTableView.frame = view.bounds
    }
    
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        self.searchController.obscuresBackgroundDuringPresentation = false
//        self.searchController.searchBar.delegate = self
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
    
    private func createSpinnerForFooter() -> UIView {
        let footerView = UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
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
        
        
        
        cell.nameLabel.text = self.users[indexPath.row].login
        cell.idLabel.text = "Id: \(self.users[indexPath.row].id)"
        let imageURL = URL(string: self.users[indexPath.row].avatar_url)
        cell.avatarImage.kf.setImage(with: imageURL)
        
        
        // pagination
        self.usersTableView.tableFooterView = createSpinnerForFooter()
        
        if indexPath.row == users.count - 1 && !isPaginating {
            self.isPaginating = true
            APICaller.shared.getListOfAllUsers(searchOffset: self.searchOffset) { response in
                switch response {
                case .success(let nextUsersPage):
                    self.users += nextUsersPage
                    self.searchOffset += 30
                    DispatchQueue.main.async {
                        self.usersTableView.reloadData()
                    }
                    self.isPaginating = false
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        }
        
        
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

extension SearchUsersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (usersTableView.contentSize.height - scrollView.frame.size.height) {
            
        }
    }
}
