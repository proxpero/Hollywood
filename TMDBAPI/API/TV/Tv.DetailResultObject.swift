import Foundation

extension TMDb.Tv {

    public struct DetailResultObject: Decodable {
        public let id: Int
        public let name: String
        public let poster: Image<Poster>?
        public let backdrop: Image<Backdrop>?
        public let overview: String
        public let firstAirDate: Date
        public let genres: [Genre]
        public let homepage: URL?
        public let inProduction: Bool
        public let episodeCount: Int
        public let seasonCount: Int
        public let popularity: Double
        public let voteCount: Int
        public let voteAverage: Double

        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
            case overview = "overview"
            case firstAirDate = "first_air_date"
            case genres = "genres"
            case homepage = "homepage"
            case inProduction = "in_production"
            case episodeCount = "number_of_episodes"
            case seasonCount = "number_of_seasons"
            case popularity = "popularity"
            case voteCount = "vote_count"
            case voteAverage = "vote_average"
        }

        private static func date(from firstAirDate: String) -> Date? {
            let df = DateFormatter()
            df.dateFormat = "YYYY-MM-DD"
            return df.date(from: firstAirDate)
        }

        public init(from decoder: Decoder) throws {
            guard
                let container = try? decoder.container(keyedBy: CodingKeys.self),
                let id = try? container.decode(Int.self, forKey: .id),
                let name = try? container.decode(String.self, forKey: .name),
                let posterPathValue = try? container.decodeIfPresent(String.self, forKey: .posterPath),
                let backdropPathValue = try? container.decodeIfPresent(String.self, forKey: .backdropPath),
                let overview = try? container.decode(String.self, forKey: .overview),
                let firstAirDateString = try? container.decode(String.self, forKey: .firstAirDate),
                let firstAirDate = DetailResultObject.date(from: firstAirDateString),
                let genres = try? container.decode([GenreResultObject].self, forKey: .genres),
                let homepageString = try? container.decode(String.self, forKey: .homepage),
                let inProduction = try? container.decode(Bool.self, forKey: .inProduction),
                let episodeCount = try? container.decode(Int.self, forKey: .episodeCount),
                let seasonCount = try? container.decode(Int.self, forKey: .seasonCount),
                let popularity = try? container.decode(Double.self, forKey: .popularity),
                let voteCount = try? container.decode(Int.self, forKey: .voteCount),
                let voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
            else { throw TMDbError.Tv.decoding }

            self.id = id
            self.name = name
            self.poster = Image<Poster>(path: posterPathValue)
            self.backdrop = Image<Backdrop>(path: backdropPathValue)
            self.overview = overview
            self.firstAirDate = firstAirDate
            self.genres = genres.compactMap { $0.genre }
            self.homepage = URL(string: homepageString)
            self.inProduction = inProduction
            self.episodeCount = episodeCount
            self.seasonCount = seasonCount
            self.popularity = popularity
            self.voteCount = voteCount
            self.voteAverage = voteAverage
            }
    }
}
