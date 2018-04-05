//import UIKit
//import SafariServices
//import TMDbAPI
//import UtilityKit
//
//typealias SessionId = String
//
//final class SessionRenewalService {
//
//    static var requestTokenValidationDidSucceedNotificationName = Notification.Name(rawValue: "com.proxpero.Hollywood.Authenticator.requestTokenValidationDidSucceedNotificationName")
//    static var requestTokenValidationDidSucceed = CustomNotificationDescriptor<String>(name: requestTokenValidationDidSucceedNotificationName)
//
//    private let tmdb: TMDb
//    private let logInViewController: LogInViewController
//    private var notificationToken: Token?
//    private var completion: (SessionId) -> () = { _ in }
//
//    private let baseUrl = URL(string: "https://www.themoviedb.org")!
//    private static let requestTokenRedirectHost = "requestToken"
//
//    init(tmdb: TMDb,
//         webservice: Webservice = Webservice(),
//         logInViewController: LogInViewController = LogInViewController.instantiate(),
//         center: NotificationCenter = NotificationCenter.default,
//         completion: @escaping (SessionId) -> ())
//    {
//        self.tmdb = tmdb
//        self.webservice = webservice
//        self.logInViewController = logInViewController
//        self.completion = completion
//        logInViewController.didTapLogIn = didTapLogIn
//        self.notificationToken = center.addObserver(descriptor: SessionRenewalService.requestTokenValidationDidSucceed) { token in
//            self.retrieveSessionId(requestToken: token)
//        }
//    }
//
//    func present(with presentingViewController: UIViewController) {
//        presentingViewController.present(logInViewController, animated: true)
//    }
//
//    private func didTapLogIn() {
//        retriveRequestToken(tokenHandler: presentTMDBValidation)
//    }
//
//    private func retriveRequestToken(tokenHandler: @escaping (RequestToken) -> ()) {
//        let url = tmdb.auth.newRequestToken
//        let token = Resource<RequestToken>(url: url)
//        webservice.load(token) { result in
//            switch result {
//            case .success(let key):
//                tokenHandler(key)
//            case .error(let error):
//                print(error)
//            }
//        }
//    }
//
//    private func requestTokenValidationURL(for requestToken: String) -> URL {
//        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
//        components?.path = "/authenticate/\(requestToken)"
//        components?.queryItems = [
//            URLQueryItem(name: "redirect_to", value: "hollywood://\(SessionRenewalService.requestTokenRedirectHost)")
//        ]
//        guard let url = components?.url else { return baseURL }
//        return url
//    }
//
//    private func presentTMDBValidation(requestToken: RequestToken) {
//        let url = requestTokenValidationURL(for: requestToken.value)
//        let vc = SFSafariViewController(url: url)
//        DispatchQueue.main.async {
//            self.logInViewController.present(vc, animated: true)
//        }
//    }
//
//    private func retrieveSessionId(requestToken: String) {
//        let url = tmdb.auth.newSession(requestToken: requestToken)
//        let resource = Resource<SessionToken>(url: url)
//        webservice.load(resource) { result in
//            switch result {
//            case .success(let session):
//                 self.completion(session.id)
//            case .error(let error):
//                print("ERROR: \(error)")
//            }
//        }
//    }
//
//    private struct SessionToken: Decodable {
//
//        let id: String
//
//        enum CodingKeys: String, CodingKey {
//            case id = "session_id"
//            case success = "success"
//        }
//
//        init(from decoder: Decoder) throws {
//            guard let container = try? decoder.container(keyedBy: CodingKeys.self),
//                let didSucceed = try? container.decode(Bool.self, forKey: .success),
//                didSucceed,
//                let id = try? container.decode(String.self, forKey: .id)
//            else {
//                throw SessionError.decodingSessionToken
//            }
//            self.id = id
//        }
//    }
//
//    private struct RequestToken: Decodable {
//
//        let value: String
//
//        private enum CodingKeys: String, CodingKey {
//            case expiration = "expires_at"
//            case token = "request_token"
//            case success = "success"
//        }
//
//        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            let expiration = try container.decode(String.self, forKey: .expiration)
//            let token = try container.decode(String.self, forKey: .token)
//            let success = try container.decode(Int.self, forKey: .success)
//            guard let result = RequestToken(expiration: expiration, token: token, success: success) else {
//                throw SessionError.decodingRequestToken
//            }
//            self = result
//        }
//
//        init?(expiration: String, token: String, success: Int) {
//            let dateFormat = "yyyy-MM-dd HH:mm:ss Z"
//            guard success == 1, let date = Date(string: expiration, dateFormat: dateFormat), date.isLater(than: Date.now) else { return nil }
//            self.value = token
//        }
//
//    }
//
//    static func requestToken(for url: URL) -> String? {
//        guard
//            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
//            let host = components.host,
//            host == requestTokenRedirectHost,
//            let queryItems = components.queryItems
//            else { return nil }
//
//        let queryDict = queryItems.reduce(into: [String: String]()) { $0[$1.name] = $1.value }
//        let isApproved = queryDict["approved"] == "true"
//        let requestToken = queryDict["request_token"]
//        guard isApproved, let token = requestToken else { return nil }
//
//        return token
//    }
//    
//}

