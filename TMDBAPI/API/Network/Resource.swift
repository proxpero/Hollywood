import Foundation

/// A representation of a resource on the internet, encapsulating the location
/// of the data, and how to parse the data into an `A`.
public struct Resource<A> {

    /// The URL of the resource.
    public let url: URL

    /// The HTTPMethod ('get', 'post', etc.)
    public let method: HttpMethod<Data>

    /// A function to convert the received data to an `A`.
    public let parse: (Data) -> A?

    public init(url: URL, method: HttpMethod<Data> = .get, parse: @escaping (Data) -> A?) {
        self.url = url
        self.method = method
        self.parse = parse
    }

}

extension Resource {
    public init(url: URL, method: HttpMethod<Data> = .get, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = method.map { json -> Data in
            let result = try! JSONSerialization.data(withJSONObject: json, options: [])
            return result
        }
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}

extension Resource where A: Decodable {
    public init(url: URL) {
        self.url = url
        self.method = .get
        self.parse = { try? JSONDecoder().decode(A.self, from: $0) }
    }
}
