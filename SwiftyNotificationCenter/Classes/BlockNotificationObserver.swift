//
//  BlockNotificationObserver.swift
//  Pods
//
//  Created by Vladislav Maltsev on 04.12.16.
//
//

import Foundation

internal class BlockNotificationObserver<EventType: ObservableEvent>: NotificationObserver<EventType> {
    private var callback: (EventType) -> Void
    
    internal init(notificationCenter: NotificationCenter, object: Any?, callback: @escaping (EventType) -> Void) {
        self.callback = callback
        super.init(notificationCenter: notificationCenter, object: object)
    }
    
    internal override func process(event: EventType) {
        callback(event)
    }
}
