import Foundation

extension TMDb.Movie {

    public struct DetailResultObject: Decodable {
        public let id: Int
        public let title: String
        public let tagline: String?
        public let posterImage: Image<Poster>?
        public let backdropImage: Image<Backdrop>?
        public let overview: String
        public let releaseDate: Date
        public let runtime: Int
        public let homepage: URL?
        public let genres: [Genre]
        public let originalTitle: String
        public let originalLanguage: String
        public let popularity: Double
        public let voteCount: Int
        public let voteAverage: Double
        public let hasVideo: Bool

        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case tagline = "tagline"
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
            case overview = "overview"
            case releaseDate = "release_date"
            case runtime = "runtime"
            case homepage = "homepage"
            case genres = "genres"
            case originalTitle = "original_title"
            case originalLanguage = "original_language"
            case popularity = "popularity"
            case voteCount = "vote_count"
            case voteAverage = "vote_average"
            case hasVideo = "video"
        }

        private static func date(from releaseDate: String) -> Date? {
            let df = DateFormatter()
            df.dateFormat = "YYYY-MM-DD"
            return df.date(from: releaseDate)
        }

        public init(from decoder: Decoder) throws {
            guard
                let container = try? decoder.container(keyedBy: CodingKeys.self),
                let id = try? container.decode(Int.self, forKey: .id),
                let title = try? container.decode(String.self, forKey: .title),
                let tagline = try? container.decodeIfPresent(String.self, forKey: .tagline),
                let posterPathValue = try? container.decode(String.self, forKey: .posterPath),
                let overview = try? container.decode(String.self, forKey: .overview),
                let releaseDateString = try? container.decode(String.self, forKey: .releaseDate),
                let releaseDate = DetailResultObject.date(from: releaseDateString),
                let runtime = try? container.decode(Int.self, forKey: .runtime),
                let homepageUrlString = try? container.decodeIfPresent(String.self, forKey: .homepage),
                let genres = try? container.decode([GenreResultObject].self, forKey: .genres),
                let originalTitle = try? container.decode(String.self, forKey: .originalTitle),
                let originalLanguage = try? container.decode(String.self, forKey: .originalLanguage),
                let backdropPathValue = try? container.decode(String.self, forKey: .backdropPath),
                let popularity = try? container.decode(Double.self, forKey: .popularity),
                let voteCount = try? container.decode(Int.self, forKey: .voteCount),
                let voteAverage = try? container.decode(Double.self, forKey: .voteAverage),
                let hasVideo = try? container.decode(Bool.self, forKey: .hasVideo)
            else { throw TMDbError.Movie.decoding }

            self.id = id
            self.title = title
            self.tagline = tagline
            self.posterImage = Image<Poster>(path: posterPathValue)
            self.overview = overview
            self.releaseDate = releaseDate
            self.runtime = runtime
            if let homepage = homepageUrlString, let url = URL(string: homepage) {
                self.homepage = url
            } else {
                self.homepage = nil
            }
            self.genres = genres.compactMap { $0.genre }
            self.originalTitle = originalTitle
            self.originalLanguage = originalLanguage
            self.backdropImage = Image<Backdrop>(path: backdropPathValue)
            self.popularity = popularity
            self.voteCount = voteCount
            self.voteAverage = voteAverage
            self.hasVideo = hasVideo
        }

        public var year: String {
            let year = Calendar.current.component(.year, from: releaseDate)
            return String(year)
        }
    }
}
