import Foundation
import Promises

public protocol NetworkEngine {
    func load<A>(_ resource: Resource<A>) -> Promise<A>
}

enum NetworkingError: Error {
    case decoding
}

extension URLSession {

    public enum Error: Swift.Error {
        case invalid
        case parsing
    }

    public func dataTask(with request: URLRequest) -> Promise<(data: Data, response: URLResponse)> {
        return Promise { fulfill, reject in
            self.dataTask(with: request) { (data, response, error) in
                if let data = data, let response = response {
                    fulfill((data, response))
                } else if let error = error {
                    reject(error)
                } else {
                    reject(URLSession.Error.invalid)
                }
                }.resume()
        }
    }

    public func dataTask(with url: URL) -> Promise<(data: Data, response: URLResponse)> {
        let request = URLRequest(url: url)
        return dataTask(with: request)
    }

}


extension URLSession: NetworkEngine {

    public func load<A>(_ resource: Resource<A>) -> Promise<A> {
        let url = resource.url
        return dataTask(with: url).then { (data, _) in
            if let result = resource.parse(data) {
                return Promise(result)
            } else {
                return Promise(Error.parsing)
            }
        }
    }
}
