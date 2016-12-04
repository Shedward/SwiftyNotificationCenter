//
//  Events.swift
//  SwiftyNotificationCenter
//
//  Created by Vladislav Maltsev on 04.12.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
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
