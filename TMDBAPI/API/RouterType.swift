import Foundation

protocol RouterType {
    var path: String { get }
    func queryItems(apiKey: ApiKey) -> [URLQueryItem]
    func url(baseUrl: URL, apiKey: ApiKey) -> URL
    func url(baseUrl: URL, apiKey: ApiKey, appendOptions: AppendOptions) -> URL
    func queryItem(from apiKey: ApiKey) -> URLQueryItem
}

extension RouterType {

    func queryItem(from apiKey: ApiKey) -> URLQueryItem {
        return URLQueryItem(name: "api_key", value: apiKey)
    }

    func queryItems(apiKey: ApiKey) -> [URLQueryItem] {
        return [queryItem(from: apiKey)]
    }

    func url(baseUrl: URL, apiKey: ApiKey) -> URL {
        return url(baseUrl: baseUrl, apiKey: apiKey, appendOptions: [])
    }

    func url(baseUrl: URL, apiKey: ApiKey, appendOptions: AppendOptions = []) -> URL {
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        components?.path.append(path)
        components?.queryItems = queryItems(apiKey: apiKey) + appendOptions.queryItems
        return components!.url!
    }
}
