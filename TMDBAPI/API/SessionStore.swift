import Foundation
import Security

public struct SessionStore {

    private static let serviceName = "com.proxpero.TMDbApi.SecureSessionStore.ServiceName"
    private let serviceName: String

    public init() {
        self.serviceName = SessionStore.serviceName
    }

    public init(serviceName: String) {
        self.serviceName = serviceName
    }

    func retrievalQuery(serviceName: String) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = serviceName as AnyObject
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        return query
    }

    func retrieveSessionId(status: OSStatus, queryResult: AnyObject?) -> String? {
        guard
            status != errSecItemNotFound,
            status == noErr,
            let existingItem = queryResult as? [String : AnyObject],
            let data = existingItem[kSecValueData as String] as? Data,
            let result = String(data: data, encoding: String.Encoding.utf8)
        else {
            return nil
        }
        return result
    }

    func setSessionId(encodedData: Data) -> Bool {
        let query = setterQuery(encodedSessionId: encodedData)
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == noErr else {
            print("Could not set session id. Removing secret.")
            return removeSessionId()
        }
        return true
    }

    func removalQuery() -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = serviceName as AnyObject
        return query
    }

    func setterQuery(encodedSessionId: Data) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = serviceName as AnyObject
        query[kSecValueData as String] = encodedSessionId as AnyObject?
        return query
    }

    public var sessionId: String? {
        let query = retrievalQuery(serviceName: serviceName)
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        return retrieveSessionId(status: status, queryResult: queryResult)
    }

    public func setSessionId(_ newValue: String) -> Bool {
        return setSessionId(encodedData: newValue.data(using: .utf8)!)
    }

    public func removeSessionId() -> Bool {
        let query = removalQuery()
        let status = SecItemDelete(query as CFDictionary)
        guard status == noErr || status == errSecItemNotFound else {
            print("ERROR: Tried to remove a keychain item from the secure session store but it does not exist.")
            return false
        }
        return true
    }

}
