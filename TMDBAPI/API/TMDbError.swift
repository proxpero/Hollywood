enum TMDbError {
    enum Auth: Error {
        case requestToken
        case session
    }

    enum Movie: Error {
        case decoding
    }

    enum Tv: Error {
        case decoding
    }
}
