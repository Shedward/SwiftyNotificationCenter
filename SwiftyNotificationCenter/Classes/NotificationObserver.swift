//
//  NotificationObserver.swift
//  Pods
//
//  Created by Vladislav Maltsev on 04.12.16.
//
//

import Foundation

private var SwiftyNotificationDisposeBagKey = "SwiftyNotificationDisposeBagKey"

public typealias NotificationDisposeBag = [Any]

public class NotificationObserver<EventType: ObservableEvent> {
    
    private weak var notificationCenter: NotificationCenter?
    
    internal init(notificationCenter: NotificationCenter, object: Any? = nil) {
        self.notificationCenter = notificationCenter
        
        notificationCenter.addObserver(self,
                                       selector: #selector(notificationDidReceived(notification:)),
                                       name: EventType.notificationName(),
                                       object: object)
    }
    
    deinit {
        notificationCenter?.removeObserver(self)
    }
    
    public func disposeWith(object: Any) {
        let associatedObject = objc_getAssociatedObject(object, &SwiftyNotificationDisposeBagKey)
        
        var disposeBag = associatedObject as? NSMutableArray ?? NSMutableArray()
        disposeBag.add(self)
        
        objc_setAssociatedObject(object, &SwiftyNotificationDisposeBagKey, disposeBag, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public func disposeWith(disposeBag: inout NotificationDisposeBag) {
        disposeBag.append(self)
    }
    
    @objc private func notificationDidReceived(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let event = EventType.fromUserInfo(userInfo)
        process(event: event)
    }
    
    internal func process(event: EventType) {
        fatalError("SwiftyNotification: Abstract NotificationObserver can not process events.")
    }
}
