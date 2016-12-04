//
//  NotificationObserver.swift
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
