import Foundation

public extension URLSession {
    static var ephemeral = URLSession.init(configuration: URLSessionConfiguration.ephemeral)
}
