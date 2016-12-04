//
//  SubscriptionViewController.swift
//  SwiftyNotificationCenter
//
//  Created by Vladislav Maltsev on 04.12.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
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
