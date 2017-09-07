//
//  ViewController.swift
//  Simple GitHub
//
//  Created by Oleg Batura on 9/6/17.
//  Copyright © 2017 DariaK. All rights reserved.
//

import UIKit
import Alamofire
import p2_OAuth2

class ViewController: UIViewController {
    fileprivate var alamofireManager: SessionManager?

    var loader: OAuth2DataLoader?
    var oauth2 = OAuth2CodeGrant(settings: [
        "client_id": "8ae913c685556e73a16f",
        "client_secret": "60d81efcc5293fd1d096854f4eee0764edb2da5d",
        "authorize_uri": "https://github.com/login/oauth/authorize",
        "token_uri": "https://github.com/login/oauth/access_token",
        "scope": "user repo:status",
        "redirect_uris": ["ppoauthapp://oauth/callback"],
        "secret_in_body": true,
        "verbose": true,
        ] as OAuth2JSON)
    
    @IBOutlet weak var LogInButton: UIButton!
    
    @IBAction func logInEmbedded(_ sender: UIButton?) {
        sender?.setTitle("Loading...", for: UIControlState.normal)
        let sessionManager = SessionManager()
        let retrier = OAuth2RetryHandler(oauth2: oauth2)
        sessionManager.adapter = retrier
        sessionManager.retrier = retrier
        alamofireManager = sessionManager
        
        sessionManager.request("https://api.github.com/user").validate().responseJSON { response in
            debugPrint("USER: ", response)
            if let userDict = response.result.value as? [String: Any] {
                DataManager.setupUser(dict: userDict)
                
                sessionManager.request("https://api.github.com/user/repos").validate().responseJSON { response in
                    debugPrint("REPOS: ", response)
                    if let reposArr = response.result.value as? [[String: Any]] {
                        DataManager.setupRepos(arr: reposArr)
                        
                        let navigationViewController = UINavigationController()
                        let mainView = ReposViewController()
                        navigationViewController.viewControllers = [mainView]
                        self.present(navigationViewController, animated: true, completion: nil)
                    }
                    else {
                        self.didCancelOrFail(OAuth2Error.generic("\(response)"))
                    }
                }
            }
            else {
                self.didCancelOrFail(OAuth2Error.generic("\(response)"))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        LogInButton.isHidden = true
    }
    
    func enableLogInButton() {
        LogInButton?.isHidden = false
    }
    
    func didCancelOrFail(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                print("Authorization went wrong: \(error)")
            }
        }
    }
    
    
}

