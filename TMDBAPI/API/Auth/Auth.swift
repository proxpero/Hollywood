import Foundation

extension TMDb {
    
    public struct Auth {

        private let baseURL: URL
        private let apiKey: String

        init(baseURL: URL, apiKey: String) {
            self.baseURL = baseURL
            self.apiKey = apiKey
        }

        public var newRequestToken: URL {
            return Auth.Router.newRequestToken.url(baseUrl: baseURL, apiKey: apiKey)
        }

        public func newSession(requestToken: String) -> URL {
            return Auth.Router.newSession(requestToken: requestToken).url(baseUrl: baseURL, apiKey: apiKey)
        }
    }
}

extension TMDb.Auth {
    
    struct RequestToken: Decodable {

        let value: String

        private enum CodingKeys: String, CodingKey {
            case expiration = "expires_at"
            case token = "request_token"
            case success = "success"
        }

        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            return formatter
        }()

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let expiration = try container.decode(String.self, forKey: .expiration)
            let token = try container.decode(String.self, forKey: .token)
            let success = try container.decode(Int.self, forKey: .success)
            guard success == 1, let date = Date(string: expiration, dateFormatter: dateFormatter), date < Date.init() else {
                throw TMDbError.Auth.requestToken
            }
            self.value = token
        }

    }

    struct SessionToken: Decodable {

        let value: String

        private enum CodingKeys: String, CodingKey {
            case value = "session_id"
            case success = "success"
        }

        init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self),
                let didSucceed = try? container.decode(Bool.self, forKey: .success),
                didSucceed,
                let value = try? container.decode(String.self, forKey: .value)
                else {
                    throw TMDbError.Auth.session
            }
            self.value = value
        }
    }

}


