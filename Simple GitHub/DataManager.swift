//
//  DataManager.swift
//  Simple GitHub
//
//  Created by Oleg Batura on 9/7/17.
//  Copyright © 2017 DariaK. All rights reserved.
//

import Foundation

struct User {
    let login: String
    let name: String
    let public_repos: Int
}

struct Repo {
    let repoName: String
    let repoDescription: String
    let repoDate: String
}

class AllData {
    var user: User?
    var repos: [Repo]? = [Repo]()
}

class DataManager {
    static let manager = DataManager()
    static let allData = AllData()

    
    class func setupUser(dict: [String : Any]) {
        if let name = dict["name"] as? String {
            if let login = dict["login"] as? String {
                if let reposCount = dict["public_repos"] as? Int {
                    let user = User(login: login,
                                    name: name,
                                    public_repos: reposCount)
                    DataManager.allData.user = user
                }
            }
        }
    }
    
    class func setupRepos(arr: [[String: Any]]) {
        for i in arr {
            if let repoName = i["name"] as? String {
                if let repoDate = i["updated_at"] as? String {
                    var description: String = "Empty description"
                    if let repoDescription = i["description"] as? String {
                        description = repoDescription
                    }
                    
                    let repo = Repo(repoName: repoName,
                                    repoDescription: description,
                                    repoDate: repoDate)
                    DataManager.allData.repos?.append(repo)
                }
            }
        }
        
    }
    
}
