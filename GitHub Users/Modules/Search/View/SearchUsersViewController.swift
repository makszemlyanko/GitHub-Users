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
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        table.backgroundColor = UIColor.backgroundDarkGray
    
        table.register(nib, forCellReuseIdentifier: UserTableViewCell.cellId)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(usersTableView)
        usersTableView.dataSource = self
        usersTableView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usersTableView.frame = view.bounds
    }

}

extension SearchUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellId, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension SearchUsersViewController: UITableViewDelegate {
    
}


