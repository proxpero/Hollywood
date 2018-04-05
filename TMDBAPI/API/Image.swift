import Foundation

public protocol ImageType {}

public enum Poster: ImageType {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

public enum Logo: ImageType {
    case w45
    case w92
    case w154
    case w185
    case w300
    case w500
    case original
}

public enum Still: ImageType {
    case w92
    case w185
    case w300
    case original
}

public enum Backdrop: ImageType {
    case w300
    case w780
    case w1280
    case original
}

public enum Profile: ImageType {
    case w45
    case w185
    case h632
    case original
}

public struct Image<A: ImageType> {

    let baseUrl: URL
    let path: String

    public init?(path: String?, baseUrl: URL = URL(string: "https://image.tmdb.org/t/p/")!) {
        guard let path = path else { return nil }
        self.path = path
        self.baseUrl = baseUrl
    }

    public func url(size: A) -> URL {
        return baseUrl
            .appendingPathComponent("\(size)")
            .appendingPathComponent(path)
    }
}
