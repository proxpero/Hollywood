import Foundation

extension TMDb {
    public struct Movie {
        private let api: MovieApiDataSource
        public init(api: MovieApiDataSource) {
            self.api = api
        }
    }
}

extension TMDb.Movie {

    public func detailsUrl(for movieId: Id, appending appendOptions: AppendOptions = []) -> URL {
        return Router
            .details(movieId)
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

    public func nowPlayingUrl(page: Page = 1) -> URL {
        return Router
            .nowPlaying(page, api.language, api.region)
            .url(baseUrl: api.baseUrl, apiKey: api.key)
    }

    public func upcomingUrl(page: Page = 1) -> URL {
        return Router
            .upcoming(page, api.language, api.region)
            .url(baseUrl: api.baseUrl, apiKey: api.key)
    }

    public func creditsUrl(for movieId: Id) -> URL {
        return Router
            .credits(movieId)
            .url(baseUrl: api.baseUrl, apiKey: api.key)
    }
}

extension TMDb.Movie {

    public func details(for movieId: Id, appending appendOptions: AppendOptions = []) -> Resource<DetailResultObject> {
        let url = detailsUrl(for: movieId, appending: appendOptions)
        let resource = Resource<DetailResultObject>(url: url)
        return resource
    }

    public func popular(page: Page = 1) -> Resource<[ListResultObject]> {
        let url = popularUrl(page: page)
        return Resource<[ListResultObject]>(url: url, parse: parseList)
    }

    public func topRated(page: Page = 1) -> Resource<[ListResultObject]> {
        let url = topRatedUrl(page: page)
        return Resource<[ListResultObject]>(url: url, parse: parseList)
    }

    public func nowPlaying(page: Page = 1) -> Resource<[ListResultObject]> {
        let url = nowPlayingUrl(page: page)
        return Resource<[ListResultObject]>(url: url, parse: parseList)
    }

    public func upcoming(page: Page = 1) -> Resource<[ListResultObject]> {
        let url = upcomingUrl(page: page)
        return Resource<[ListResultObject]>(url: url, parse: parseList)
    }

    public func credits(for movieId: Id) -> Resource<CreditsObject> {
        let url = creditsUrl(for: movieId)
        return Resource<CreditsObject>(url: url)
    }

    // Private

    private func parseList(data: Data) -> [TMDb.Movie.ListResultObject]? {
        let list = try? JSONDecoder().decode(TMDb.Movie.List.self, from: data)
        return list?.resultObjects
    }
}

