import Foundation

extension TMDb.Auth {

    enum Router: RouterType {

        case newRequestToken
        case newSession(requestToken: String)

        var path: String {
            switch self {
            case .newRequestToken:  return "/authentication/token/new"
            case .newSession:       return "/authentication/session/new"
            }
        }

        func queryItems(apiKey: String) -> [URLQueryItem] {
            let apiKeyQueryItem = URLQueryItem(name: "api_key", value: apiKey)
            switch self {
            case .newRequestToken: return [apiKeyQueryItem]
            case .newSession(let requestToken): return [
                    apiKeyQueryItem,
                    URLQueryItem(name: "request_token", value: requestToken)
                ]
            }
        }

    }

}
