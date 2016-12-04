//
//  ViewController.swift
//  SwiftyNotificationCenter
//
//  Created by Vladislav Maltsev on 12/04/2016.
//  Copyright (c) 2016 Vladislav Maltsev. 
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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

