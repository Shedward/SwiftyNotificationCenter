//
//  ViewController.swift
//  SwiftyNotificationCenter
//
//  Created by Vladislav Maltsev on 12/04/2016.
//  Copyright (c) 2016 Vladislav Maltsev. All rights reserved.
//

import UIKit
import SwiftyNotificationCenter

class ViewController: UIViewController {
    
    @IBOutlet weak var subsciptionStateLabel: UILabel!
    
    private var subscriptionObserver: NotificationObserver<SubscriptionStateChanged>?
    
    override func viewDidLoad() {
        
        subscriptionObserver = NotificationCenter.default.observe { [unowned self] event in
            let message: String
            switch event {
            case .free:
                message = "free"
            case .premium:
                message = "premium"
            case .promo("new year"):
                message = "happy new year"
            case .promo(let text):
                message = "Promo \(text)"
            }
            
            self.subsciptionStateLabel.text = message
        }
    }
    
    @IBAction func logoutDidPressed() {
        NotificationCenter.default.post(event: LoginStateChanged(userIsLoggedIn: false))
    }
    
    @IBAction func unwindToMainPage(segue: UIStoryboardSegue) {
    }
}

