import Foundation

extension TMDb {

    public struct Tv {
        private let api: TvApiDataSource
        public init(api: TvApiDataSource) {
            self.api = api
        }
    }
}

extension TMDb.Tv {

    public func detailsUrl(for tvId: Id, appending appendOptions: AppendOptions = []) -> URL {
        return Router
            .details(tvId)
            .url(baseUrl: api.baseUrl, apiKey: api.key, appendOptions: appendOptions)
    }

    public func popularUrl(page: Page = 1) -> URL {
        return Router
            .popular(page, api.language, api.region)
            .url(baseUrl: api.baseUrl, apiKey: api.key)
    }

    public func topRatedUrl(page: Page = 1) -> URL {
        return Router
            .topRated(page, api.language, api.region)
            .url(baseUrl: api.baseUrl, apiKey: api.key)
    }

    public func onTheAirUrl(page: Page = 1) -> URL {
        return Router
            .onTheAir(page, api.language, api.region)
            .url(baseUrl: api.baseUrl, apiKey: api.key)
    }

    public func airingTodayUrl(page: Page = 1) -> URL {
        return Router
            .airingToday(page, api.language, api.region)
            .url(baseUrl: api.baseUrl, apiKey: api.key)
    }
}

extension TMDb.Tv {

    public func details(for tvId: Id, appending appendOptions: AppendOptions = []) -> Resource<DetailResultObject> {
        let url = detailsUrl(for: tvId, appending: appendOptions)
        let resource = Resource<DetailResultObject>(url: url)
        return resource
    }

    private func listResults(for url: URL) -> Resource<[ListResultObject]> {
        return Resource<[ListResultObject]>(url: url, parse: parseList)
    }

    private func parseList(data: Data) -> [ListResultObject]? {
        let list = try? JSONDecoder().decode(List.self, from: data)
        return list?.resultObjects
    }

    public func popular(page: Page = 1) -> Resource<[ListResultObject]> {
        return listResults(for: popularUrl(page: page))
    }

    public func topRated(page: Page = 1) -> Resource<[ListResultObject]> {
        return listResults(for: topRatedUrl(page: page))
    }

    public func onTheAir(page: Page = 1) -> Resource<[ListResultObject]> {
        return listResults(for: onTheAirUrl(page: page))
    }

    public func airingToday(page: Page = 1) -> Resource<[ListResultObject]> {
        return listResults(for: airingTodayUrl(page: page))
    }
}
