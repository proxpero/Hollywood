class Coordinator {}

extension Coordinator: Hashable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}
