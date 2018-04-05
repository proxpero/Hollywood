enum HollywoodError: Error {

}

enum SessionError: Error {
    case failedToCreateRedirectURL
    case decodingSessionToken
    case decodingRequestToken
}
