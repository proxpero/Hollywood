import Foundation

extension TMDb.Movie {

    public struct ListResultObject: Decodable {
        public let id: Int
        public let title: String
        public let posterPath: Image<Poster>?
        public let backdropPath: Image<Backdrop>?
        public let overview: String
        public let releaseDate: Date
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
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
            case overview = "overview"
            case releaseDate = "release_date"
            case genreIds = "genre_ids"
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
                let posterPathValue = try? container.decodeIfPresent(String.self, forKey: .posterPath),
                let overview = try? container.decode(String.self, forKey: .overview),
                let releaseDateString = try? container.decode(String.self, forKey: .releaseDate),
                let releaseDate = ListResultObject.date(from: releaseDateString),
                let genreIds = try? container.decode([Int].self, forKey: .genreIds),
                let originalTitle = try? container.decode(String.self, forKey: .originalTitle),
                let originalLanguage = try? container.decode(String.self, forKey: .originalLanguage),
                let backdropPathValue = try? container.decodeIfPresent(String.self, forKey: .backdropPath),
                let popularity = try? container.decode(Double.self, forKey: .popularity),
                let voteCount = try? container.decode(Int.self, forKey: .voteCount),
                let voteAverage = try? container.decode(Double.self, forKey: .voteAverage),
                let hasVideo = try? container.decode(Bool.self, forKey: .hasVideo)
            else {
                print("ERROR Decoding!")
                throw TMDbError.Movie.decoding
            }

            self.id = id
            self.title = title
            self.posterPath = Image<Poster>(path: posterPathValue)
            self.overview = overview
            self.releaseDate = releaseDate
            self.genres = genreIds.compactMap { Genre(rawValue: $0) }
            self.originalTitle = originalTitle
            self.originalLanguage = originalLanguage
            self.backdropPath = Image<Backdrop>(path: backdropPathValue)
            self.popularity = popularity
            self.voteCount = voteCount
            self.voteAverage = voteAverage
            self.hasVideo = hasVideo
        }
    }

    public struct List: Decodable {
        public let resultObjects: [ListResultObject]

        private enum CodingKeys: String, CodingKey {
            case results
        }
        public init(from decoder: Decoder) throws {
            guard
                let container = try? decoder.container(keyedBy: CodingKeys.self),
                let results = try? container.decode([ListResultObject].self, forKey: .results)
            else { throw TMDbError.Tv.decoding }
            self.resultObjects = results
        }
    }

}

