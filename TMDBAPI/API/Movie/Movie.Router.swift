import Foundation
import UtilityKit

extension TMDb.Movie {

    enum Router: RouterType {        
        case details(Id)
        case popular(Page, Language, Region)
        case topRated(Page, Language, Region)
        case nowPlaying(Page, Language, Region)
        case upcoming(Page, Language, Region)
        case credits(Id)
        
        var path: String {
            switch self {
            case .details(let id): return "/movie/\(id)"
            case .popular: return "/movie/popular"
            case .topRated: return "/movie/top_rated"
            case .nowPlaying: return "/movie/now_playing"
            case .upcoming: return "/movie/upcoming"
            case .credits(let id): return "/movie/\(id)/credits"
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
            case .nowPlaying(let page, let language, let region):
                return [URLQueryItem].init(apiKey: apiKey, page: page, language: language, region: region)
            case .upcoming(let page, let language, let region):
                return [URLQueryItem].init(apiKey: apiKey, page: page, language: language, region: region)
            case .credits:
                return [QueryType.apiKey(apiKey).item]
            }
        }
    }
}
