//
//  AppDelegate.swift
//  Simple GitHub
//
//  Created by Oleg Batura on 9/6/17.
//  Copyright © 2017 DariaK. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let vc = window?.rootViewController as? ViewController {
            if (vc.oauth2.accessToken) != nil {
                vc.logInEmbedded(nil)
            } else {
                vc.enableLogInButton()
            }
            
        }
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if "ppoauthapp" == url.scheme || (url.scheme?.hasPrefix("com.googleusercontent.apps"))! {
            if let vc = window?.rootViewController as? ViewController {
                vc.oauth2.handleRedirectURL(url)
                return true
            }
        }
        return false
    }
}

