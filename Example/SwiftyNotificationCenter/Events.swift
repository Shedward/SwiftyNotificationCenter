//
//  Events.swift
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

import Foundation
import SwiftyNotificationCenter

struct LoginStateChanged: PostableEvent, ObservableEvent {
    let userIsLoggedIn: Bool
    
    init(userIsLoggedIn: Bool) {
        self.userIsLoggedIn = userIsLoggedIn
    }
}

enum SubscriptionStateChanged: PostableEvent, ObservableEvent {
    case free
    case premium
    case promo(name: String)
}

class KeyboardEvent {
    let beginFrame: CGRect
    let endFrame: CGRect
    
    let animationCurve: UIViewAnimationCurve
    let animationDuration: Double
    
    let isLocal: Bool
    
    init(fromFrame:CGRect, toFrame: CGRect,
                 withAnimationCurve curve: UIViewAnimationCurve,
                 duration: Double, local isLocal: Bool)
    {
        self.beginFrame = fromFrame
        self.endFrame = toFrame
        
        self.animationCurve = curve
        self.animationDuration = duration
        self.isLocal = isLocal
    }
    
    convenience init(userInfo:[AnyHashable: Any]) {
        let fromFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let toFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let animationCurve = UIViewAnimationCurve(rawValue: (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue)!
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let isLocal: Bool
        
        if #available(iOS 9.0, *) {
            isLocal = (userInfo[UIKeyboardIsLocalUserInfoKey] as! NSNumber).boolValue
        } else {
            isLocal = true
        }
        
        self.init(fromFrame: fromFrame, toFrame: toFrame, withAnimationCurve: animationCurve, duration: animationDuration, local: isLocal)
    }
}

final class KeyboardWillShow: KeyboardEvent, ObservableEvent {
    static func notificationName() -> Notification.Name {
        return .UIKeyboardWillShow
    }
    
    static func fromUserInfo(_ userInfo:[AnyHashable: Any]) -> Self {
        return self.init(userInfo: userInfo)
    }
}

final class KeyboardWillHide: KeyboardEvent, ObservableEvent {
    static func notificationName() -> Notification.Name {
        return .UIKeyboardWillHide
    }
    
    static func fromUserInfo(_ userInfo:[AnyHashable: Any]) -> Self {
        return self.init(userInfo: userInfo)
    }
}

final class KeyboardDidShow: KeyboardEvent, ObservableEvent {
    static func notificationName() -> Notification.Name {
        return .UIKeyboardDidShow
    }
    
    static func fromUserInfo(_ userInfo:[AnyHashable: Any]) -> Self {
        return self.init(userInfo: userInfo)
    }
}

final class KeyboardDidHide: KeyboardEvent, ObservableEvent {
    static func notificationName() -> Notification.Name {
        return .UIKeyboardDidHide
    }
    
    static func fromUserInfo(_ userInfo:[AnyHashable: Any]) -> Self {
        return self.init(userInfo: userInfo)
    }
}
