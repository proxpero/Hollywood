import UIKit
import TMDbAPI
import BoxOffice

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
        let networkEngine: NetworkEngine = URLSession.shared
        let listTypes: [TMDb.Movie.ListType] = [
            .popular,
            .topRated,
            .upcoming,
            .nowPlaying
        ]
        let appCoordinator = AppCoordinator(
            window: window,
            tmdb: tmdb,
            networkEngine: networkEngine,
            listTypes: listTypes
        )
        self.appCoordinator = appCoordinator
        window.makeKeyAndVisible()
        self.window = window

        return true
    }

    @objc func done(sender: Any) {
        print(#function)
    }

    @objc func add(sender: Any) {
        print(#function)
    }

//    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
//        if let token = SessionRenewalService.requestToken(for: url) {
//            NotificationCenter.default.post(descriptor: SessionRenewalService.requestTokenValidationDidSucceed, value: token)
//            return true
//        }
//        return false
//    }

}
