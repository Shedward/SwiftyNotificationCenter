//
//  LoginViewController.swift
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
