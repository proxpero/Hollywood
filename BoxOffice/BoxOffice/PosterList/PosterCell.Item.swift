import Foundation
import TMDbAPI

extension PosterCell {
    public struct Item {
        public let id: Int
        public let mediaType: MediaType
        public let title: String
        public var imageUrl: URL?
        public init(id: Int, mediaType: MediaType, title: String, imageUrl: URL) {
            self.id = id
            self.mediaType = mediaType
            self.title = title
            self.imageUrl = imageUrl
        }
    }
}

extension PosterCell.Item {

    public init(movieListResultObject: TMDb.Movie.ListResultObject) {
        self.id = movieListResultObject.id
        self.mediaType = .movie
        self.title = movieListResultObject.title
        self.imageUrl = movieListResultObject.posterPath?.url(size: .w185)
    }

    public init(movieListResultObject: TMDb.Movie.ListResultObject, size: Poster) {
        self.id = movieListResultObject.id
        self.mediaType = .movie
        self.title = movieListResultObject.title
        self.imageUrl = movieListResultObject.posterPath?.url(size: size)
    }
}
