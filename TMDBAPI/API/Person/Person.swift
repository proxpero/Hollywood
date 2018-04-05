import Foundation

extension TMDb {
    public struct Person {
        private let api: PersonApiDataSource

        public init(api: PersonApiDataSource) {
            self.api = api
        }

        public func detailsUrl(for personId: Id, appending appendOptions: AppendOptions = []) -> URL {
            return Person.Router
                .details(personId)
                .url(baseUrl: api.baseUrl, apiKey: api.key, appendOptions: appendOptions)
        }

        public func popularUrl(page: Page = 1) -> URL {
            return Person.Router
                .popular(page, api.language, api.region)
                .url(baseUrl: api.baseUrl, apiKey: api.key)
        }
    }
}
