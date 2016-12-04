//
//  LoginViewController.swift
//  SwiftyNotificationCenter
//
//  Created by Vladislav Maltsev on 04.12.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyNotificationCenter

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    
    var disposeBag = NotificationDisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.observe {[unowned self] (event: KeyboardWillShow) in
            self.adjustLayoutForKeyboard(event: event)
        }.disposeWith(disposeBag: &disposeBag)
        
        NotificationCenter.default.observe {[unowned self] (event: KeyboardWillHide) in
            self.adjustLayoutForKeyboard(event: event)
        }.disposeWith(disposeBag: &disposeBag)
    }
    
    @IBAction func loginDidPressed() {
        NotificationCenter.default.post(event: LoginStateChanged(userIsLoggedIn: true))
    }
    
    @IBAction func clearDidPressed() {
        self.usernameTextField.text = nil
        self.passwordTextField.text = nil
        
        self.view.endEditing(true)
    }
    
    private func adjustLayoutForKeyboard(event: KeyboardEvent) {
        let animationOptions = self.viewAnimationOptionForCurve(curve: event.animationCurve)
        
        let keyboardRect = self.view.convert(event.endFrame, from: nil)
        let keyboardOverlapRect = self.view.bounds.intersection(keyboardRect)
        self.bottomLayout.constant = keyboardOverlapRect.height
        UIView.animate(withDuration: event.animationDuration, delay: 0, options:animationOptions , animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func viewAnimationOptionForCurve(curve: UIViewAnimationCurve) -> UIViewAnimationOptions {
        switch (curve) {
        case .easeInOut:
            return UIViewAnimationOptions.curveEaseInOut
        case .easeIn:
            return UIViewAnimationOptions.curveEaseIn
        case .easeOut:
            return UIViewAnimationOptions.curveEaseOut
        case .linear:
            return UIViewAnimationOptions.curveLinear
        }
    }
}
