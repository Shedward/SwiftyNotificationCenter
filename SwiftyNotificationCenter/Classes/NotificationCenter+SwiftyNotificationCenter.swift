//
//  NotificationCenter+SwiftyNotificationCenter.swift
//  Pods
//
//  Created by Vladislav Maltsev on 04.12.16.
//
//

import Foundation

public extension NotificationCenter {
    public func post<EventType: PostableEvent>(event: EventType, fromObject object: Any? = nil) {
        self.post(name: EventType.notificationName(),
                  object: object,
                  userInfo: event.toUserInfo())
    }
    
    public func observe<EventType: ObservableEvent>(object: Any? = nil, callback:@escaping (EventType) -> Void) -> NotificationObserver<EventType>
    {
        return BlockNotificationObserver(notificationCenter: self, object: object, callback: callback)
    }
    
    public func observe<EventType: ObservableEvent>(eventsOfType:EventType.Type, fromObject object: Any? = nil, target: AnyObject, selector: Selector) -> NotificationObserver<EventType>
    {
        return TargetNotificationObserver<EventType>(notificationCenter: self, object: object, target: target, selector: selector)
    }
    
    public func observe<EventType: ObservableEvent>(eventsOfType:EventType.Type, fromObject object: Any? = nil, callback:@escaping (EventType) -> Void) -> NotificationObserver<EventType>
    {
        return self.observe(object: object, callback: callback)
    }
}
