//
//  ReposViewController.swift
//  Simple GitHub
//
//  Created by Oleg Batura on 9/6/17.
//  Copyright © 2017 DariaK. All rights reserved.
//

import UIKit

class ReposViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = DataManager.allData.user?.name
        tableView.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "Repo")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (DataManager.allData.repos?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepoCell = tableView.dequeueReusableCell(withIdentifier: "Repo", for: indexPath) as! RepoCell
        
        cell.repoName.text = DataManager.allData.repos?[indexPath.row].repoName
        cell.repoDescription.text = DataManager.allData.repos?[indexPath.row].repoDescription
        cell.repoDate.text = DataManager.allData.repos?[indexPath.row].repoDate
        cell.repoAuthor.text = DataManager.allData.user?.login

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
