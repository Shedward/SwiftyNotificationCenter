//
//  SubscriptionViewController.swift
//  SwiftyNotificationCenter
//
//  Created by Vladislav Maltsev on 04.12.16.
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

class SubscriptionViewController: UIViewController {
    
    @IBOutlet weak var promocodeTextField: UITextField!
    
    @IBAction func subscribeToPremiumDidPressed() {
    
        NotificationCenter.default.post(event: SubscriptionStateChanged.premium)
        goToMainScreen()
    }
    
    @IBAction func subscribeWithPromocodeDidPressed() {
        guard let promo = promocodeTextField.text else { return }
        guard !promo.isEmpty else { return }
        
        NotificationCenter.default.post(event: SubscriptionStateChanged.promo(name: promo))
        goToMainScreen()
    }
    
    func goToMainScreen() {
        self.performSegue(withIdentifier: "GoToMainScreen", sender: self)
    }
}
