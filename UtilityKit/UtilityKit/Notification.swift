import Foundation

public struct NotificationDescriptor<A> {
    public let name: Notification.Name
    public let parse: (Notification) -> A
    public init(name: Notification.Name, parse: @escaping (Notification) -> A) {
        self.name = name
        self.parse = parse
    }
}

public struct CustomNotificationDescriptor<A> {
    public let name: Notification.Name
    public init(name: Notification.Name) {
        self.name = name
    }
}

public final class Token {
    let token: NSObjectProtocol
    let center: NotificationCenter

    public init(token: NSObjectProtocol, center: NotificationCenter) {
        self.token = token
        self.center = center
    }

    deinit {
        center.removeObserver(token)
    }
}

extension NotificationCenter {

    public func addObserver<A>(descriptor: NotificationDescriptor<A>, using block: @escaping (A) -> ()) -> Token {
        let token = addObserver(forName: descriptor.name, object: nil, queue: nil) { (note) in
            block(descriptor.parse(note))
        }
        return Token(token: token, center: self)
    }

    // swiftlint:disable:next line_length
    public func addObserver<A>(descriptor: CustomNotificationDescriptor<A>, queue: OperationQueue? = nil, using block: @escaping (A) -> ()) -> Token {
        let token = addObserver(forName: descriptor.name, object: nil, queue: queue) { note in
            // swiftlint:disable:next force_cast
            block(note.object as! A)
        }
        return Token(token: token, center: self)
    }

    public func post<A>(descriptor: CustomNotificationDescriptor<A>, value: A) {
        post(name: descriptor.name, object: value)
    }
}

public let keyboardWillShow = NotificationDescriptor(name: .UIKeyboardWillShow) { note in
    return KeyboardWillShowPayload.init(userInfo: note.userInfo!)
}

public let keyboardDidShow = NotificationDescriptor(name: .UIKeyboardDidShow) { note in
    return KeyboardDidShowPayload.init(userInfo: note.userInfo!)
}

public let keyboardDidHide = NotificationDescriptor(name: .UIKeyboardDidHide) { note in
    return KeyboardDidHidePayload.init(userInfo: note.userInfo!)
}

public struct KeyboardWillShowPayload {
    var beginFrame: CGRect
    let endFrame: CGRect
    let animationCurve: UIViewAnimationCurve
    let animationDuration: TimeInterval
    let isLocal: Bool
    public init(userInfo: [AnyHashable:Any]) {
        // swiftlint:disable force_cast
        beginFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect
        endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let animationCurveRaw = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UIViewAnimationCurve.RawValue
        animationCurve = UIViewAnimationCurve(rawValue: animationCurveRaw)!
        animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        isLocal = userInfo[UIKeyboardIsLocalUserInfoKey] as! Bool
        // swiftlint:enable force_cast
    }

}

public struct KeyboardDidShowPayload {
    var beginFrame: CGRect
    let endFrame: CGRect
    let animationCurve: UIViewAnimationCurve
    let animationDuration: TimeInterval
    let isLocal: Bool
    public init(userInfo: [AnyHashable:Any]) {
        // swiftlint:disable force_cast
        beginFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect
        endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let animationCurveRaw = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UIViewAnimationCurve.RawValue
        animationCurve = UIViewAnimationCurve(rawValue: animationCurveRaw)!
        animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        isLocal = userInfo[UIKeyboardIsLocalUserInfoKey] as! Bool
        // swiftlint:enable force_cast
    }
}

public struct KeyboardDidHidePayload {
    var beginFrame: CGRect
    let endFrame: CGRect
    let animationCurve: UIViewAnimationCurve
    let animationDuration: TimeInterval
    let isLocal: Bool
    public init(userInfo: [AnyHashable:Any]) {
        // swiftlint:disable force_cast
        beginFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect
        endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let animationCurveRaw = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UIViewAnimationCurve.RawValue
        animationCurve = UIViewAnimationCurve(rawValue: animationCurveRaw)!
        animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        isLocal = userInfo[UIKeyboardIsLocalUserInfoKey] as! Bool
        // swiftlint:enable force_cast
    }
}
