//
//  Event.swift
//  Pods
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

private let SwiftyNotificationPrefix = "SwiftyNotification."
private let SwiftyNotificationDefaultUserInfoKey = "SwiftyNotificationData"

public protocol Event {
    static func notificationName() -> Notification.Name
}

public extension Event {
    public static func notificationName() -> Notification.Name {
        return Notification.Name(rawValue: SwiftyNotificationPrefix + String(describing: self))
    }
}


public protocol PostableEvent: Event {
    func toUserInfo() -> [AnyHashable: Any]
}

public extension PostableEvent {
    public func toUserInfo() -> [AnyHashable: Any] {
        return [SwiftyNotificationDefaultUserInfoKey: self]
    }
}


public protocol ObservableEvent: Event {
    static func fromUserInfo(_ userInfo:[AnyHashable: Any]) -> Self
}

public extension ObservableEvent {
    public static func fromUserInfo(_ userInfo:[AnyHashable: Any]) -> Self {
        guard let value = userInfo[SwiftyNotificationDefaultUserInfoKey] as? Self else {
            fatalError("SwiftyNotification: User info \(userInfo) does not contain value of type \(self) at key \(SwiftyNotificationDefaultUserInfoKey). If you want to suport custom userInfo structure override ObservableEvent.fromUserInfo(_ userInfo:)")
        }
        
        return value
    }
}
