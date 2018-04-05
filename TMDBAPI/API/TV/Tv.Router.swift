import Foundation
import UtilityKit

extension TMDb.Tv {

    enum Router: RouterType {
        case details(Id)
        case popular(Page, Language, Region)
        case topRated(Page, Language, Region)
        case onTheAir(Page, Language, Region)
        case airingToday(Page, Language, Region)

        var path: String {
            switch self {
            case .details(let id): return "/tv/\(id)"
            case .popular: return "/tv/popular"
            case .topRated: return "/tv/top_rated"
            case .onTheAir: return "/tv/on_the_air"
            case .airingToday: return "/tv/airing_today"
            }
        }

        func queryItems(apiKey: String) -> [URLQueryItem] {
            switch self {
            case .details:
                return [QueryType.apiKey(apiKey).item]
            case .popular(let page, let language, let region):
                return [URLQueryItem].init(apiKey: apiKey, page: page, language: language, region: region)
            case .topRated(let page, let language, let region):
                return [URLQueryItem].init(apiKey: apiKey, page: page, language: language, region: region)
            case .onTheAir(let page, let language, let region):
                return [URLQueryItem].init(apiKey: apiKey, page: page, language: language, region: region)
            case .airingToday(let page, let language, let region):
                return [URLQueryItem].init(apiKey: apiKey, page: page, language: language, region: region)
            }
        }
    }

}
