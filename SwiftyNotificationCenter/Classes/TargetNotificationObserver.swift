//
//  TargetNotificationObserver.swift
//  Pods
//
//  Created by Vladislav Maltsev on 04.12.16.
//
//

import Foundation

internal class TargetNotificationObserver<EventType: ObservableEvent>: NotificationObserver<EventType> {
    weak var target: AnyObject?
    let selector: Selector
    
    internal init(notificationCenter: NotificationCenter, object: Any?, target: AnyObject, selector: Selector) {
        self.target = target
        self.selector = selector
        
        super.init(notificationCenter: notificationCenter, object: object)
    }
    
    internal override func process(event: EventType) {
        target?.perform(selector, with: event)
    }
}
