// https://github.com/Quick/Quick

import Quick
import Nimble

import SwiftyNotificationCenter

struct TestEvent: PostableEvent, ObservableEvent {
    let testValue: String
    
    init(value:String) {
        self.testValue = value
    }
}

class TestObject {
    
}

let testObject = TestObject()

class SwiftyNotificationCenterSpec: QuickSpec {
    override func spec() {
        describe("NotificationCenter.post(event:)") {
            it("post only one event") {
                expect {
                    NotificationCenter.default.post(event: TestEvent(value: "test"))
                }.to(postNotifications(haveCount(1)))
            }
            
            it("post event with proper name") {
                expect {
                    NotificationCenter.default.post(event: TestEvent(value: "test"))
                }.to(postNotifications(allPass({ notification in
                    guard let notification = notification else { return false }
                    return notification.name.rawValue == TestEvent.notificationName().rawValue
                })))
            }
            
            it("post event from proper object") {
                expect {
                    NotificationCenter.default.post(event: TestEvent(value: "test"), fromObject: testObject)
                }.to(postNotifications(allPass({ notification in
                    guard let object = notification?.object as? TestObject else { return false }
                    return object === testObject
                })))
            }
            
            it("send event data in userInfo") {
                let expectedEvent = TestEvent(value: "test")
                expect {
                    NotificationCenter.default.post(event: expectedEvent)
                }.to(postNotifications(allPass({ notification in
                    guard let event = notification?.userInfo?["SwiftyNotificationData"] as? TestEvent else { return false }
                    return event.testValue == expectedEvent.testValue
                })))
            }
        }
    }
}
