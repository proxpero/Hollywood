import Foundation
import UtilityKit

public typealias ApiKey = String
public typealias SessionId = String
public typealias Id = Int
public typealias Page = Int

public final class TMDb {

    public let baseUrl: URL
    public let key: ApiKey
    public private(set) var sessionId: SessionId?
    public var language: Language
    public var region: Region

    public init(
        baseUrl: URL,
        apiKey: String,
        language: Language = .en,
        region: Region = .us,
        sessionId: String? = nil)
    {
        self.baseUrl = baseUrl
        self.key = apiKey
        self.sessionId = sessionId
        self.language = language
        self.region = region
    }

    public func setSessionId(_ sessionId: SessionId?) {
        self.sessionId = sessionId
    }
}

public protocol AuthApiDataSource: class {
    var baseUrl: URL { get }
    var key: ApiKey { get }
    func setSessionId(_ sessionId: SessionId?)
}

extension TMDb: AuthApiDataSource {}

public protocol MovieApiDataSource: class {
    var baseUrl: URL { get }
    var key: ApiKey { get }
    var sessionId: SessionId? { get }
    var language: Language { get }
    var region: Region { get }
}

extension TMDb: MovieApiDataSource {}

public protocol TvApiDataSource: class {
    var baseUrl: URL { get }
    var key: ApiKey { get }
    var sessionId: SessionId? { get }
    var language: Language { get }
    var region: Region { get }
}

extension TMDb: TvApiDataSource {}

public protocol PersonApiDataSource: class {
    var baseUrl: URL { get }
    var key: ApiKey { get }
    var sessionId: SessionId? { get }
    var language: Language { get }
    var region: Region { get }
}

extension TMDb: PersonApiDataSource {}
