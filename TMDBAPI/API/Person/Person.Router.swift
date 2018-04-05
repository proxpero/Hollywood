import Foundation
import UtilityKit

extension TMDb.Person {

    enum Router: RouterType {
        case details(Id)
        case popular(Page, Language, Region)

        var path: String {
            switch self {
            case .details(let id): return "/person/\(id)"
            case .popular: return "/person/popular"
            }
        }

        func queryItems(apiKey: ApiKey) -> [URLQueryItem] {
            switch self {
            case .details:
                return [QueryType.apiKey(apiKey).item]
            case .popular(let page, let language, let region):
                return [URLQueryItem](apiKey: apiKey, page: page, language: language, region: region)
            }
        }
    }
}
