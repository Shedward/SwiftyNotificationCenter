//
//  Event.swift
//  Pods
//
//  Created by Vladislav Maltsev on 04.12.16.
//
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
