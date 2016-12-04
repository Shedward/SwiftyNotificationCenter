//
//  AppDelegate.swift
//  SwiftyNotificationCenter
//
//  Created by Vladislav Maltsev on 12/04/2016.
//  Copyright (c) 2016 Vladislav Maltsev. All rights reserved.
//

import UIKit
import SwiftyNotificationCenter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var disposeBag = NotificationDisposeBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        showStoryboard(name: "Main")
        NotificationCenter.default.observe { [unowned self] (event: LoginStateChanged) in
            if event.userIsLoggedIn {
                self.showStoryboard(name: "Main")
            } else {
                self.showStoryboard(name: "Login")
            }
        }.disposeWith(disposeBag: &disposeBag)
        
        return true
    }
    
    func showStoryboard(name: String) {
        let initialViewController = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = initialViewController
        
        self.window?.makeKeyAndVisible()
    }
}

