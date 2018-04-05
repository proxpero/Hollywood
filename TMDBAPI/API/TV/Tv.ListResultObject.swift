import Foundation
import UtilityKit

extension TMDb.Tv {

    public struct ListResultObject: Decodable {
        public let id: Int
        public let name: String
        public let poster: Image<Poster>?
        public let backdrop: Image<Backdrop>?
        public let overview: String
        public let firstAirDate: Date
        public let genres: [Genre]
        public let popularity: Double
        public let voteCount: Int
        public let voteAverage: Double
        public let originalLanguage: Language

        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
            case overview = "overview"
            case firstAirDate = "first_air_date"
            case genreIds = "genre_ids"
            case popularity = "popularity"
            case voteCount = "vote_count"
            case voteAverage = "vote_average"
            case language = "original_language"
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
                let firstAirDate = ListResultObject.date(from: firstAirDateString),
                let genres = try? container.decode([Int].self, forKey: .genreIds),
                let popularity = try? container.decode(Double.self, forKey: .popularity),
                let voteCount = try? container.decode(Int.self, forKey: .voteCount),
                let voteAverage = try? container.decode(Double.self, forKey: .voteAverage),
                let languageCode = try? container.decode(String.self, forKey: .language),
                let language = Language(rawValue: languageCode.uppercased())
            else { throw TMDbError.Tv.decoding }

            self.id = id
            self.name = name
            self.poster = Image<Poster>(path: posterPathValue)
            self.backdrop = Image<Backdrop>(path: backdropPathValue)
            self.overview = overview
            self.firstAirDate = firstAirDate
            self.genres = genres.compactMap { Genre(rawValue: $0) }
            self.popularity = popularity
            self.voteCount = voteCount
            self.voteAverage = voteAverage
            self.originalLanguage = language
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

