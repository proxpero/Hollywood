import Foundation
import UtilityKit

enum QueryType {
    case apiKey(ApiKey)
    case page(Page)
    case language(Language)
    case region(Region)

    var item: URLQueryItem {
        switch self {
        case .apiKey(let key): return URLQueryItem(name: "api_key", value: key)
        case .page(let page): return URLQueryItem(name: "page", value: "\(page)")
        case .language(let language): return URLQueryItem(name: "language", value: language.code)
        case .region(let region): return URLQueryItem(name: "region", value: region.code)
        }
    }
}
