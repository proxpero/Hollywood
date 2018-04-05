import UIKit
import TMDbAPI
import BoxOffice
import Promises

final class AppCoordinator {

    private let navigationController: UINavigationController
    private let movie: TMDb.Movie
    private let networkEngine: NetworkEngine
    private let listTypes: [TMDb.Movie.ListType]

    init(window: UIWindow, tmdb: TMDb, networkEngine: NetworkEngine, listTypes: [TMDb.Movie.ListType]) {

        let vc = PosterListCollectionViewController(nibName: nil, bundle: nil)
        let nav = UINavigationController(rootViewController: vc)

        self.navigationController = nav
        self.movie = TMDb.Movie(api: tmdb)
        self.networkEngine = networkEngine
        self.listTypes = listTypes

        vc.networkEngine = networkEngine
        vc.didSelectPosterCellItem = didSelectMoviePosterItem
        vc.didSelectListAtIndex = didSelectListType
        
        let items = listTypes.map { movie.posterListItems(for: $0, page: 1, networkEngine: networkEngine) }
        all(items).then { vc.items = $0 }
        window.rootViewController = nav
    }

    func didSelectMoviePosterItem(_ item: PosterCell.Item) {
        let movieDetailsViewController = MovieDetails.ViewController(
            movieId: item.id,
            movie: movie,
            networkEngine: networkEngine
        )
        movieDetailsViewController.title = item.title
        movieDetailsViewController.navigationItem.backBarButtonItem?.title = nil
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }

    func didSelectListType(at index: Int) {
        let listType = listTypes[index]
        let vc = PostListGridViewController(listType: listType, networkEngine: networkEngine)
        vc.title = listType.title
        vc.didSeletPosterItem = didSelectMoviePosterItem
        vc.load = loadPosterCellItems
        vc.loadNextPage()
        navigationController.pushViewController(vc, animated: true)
    }

    func loadPosterCellItems(listType: TMDb.Movie.ListType, page: Page, completion: @escaping ([PosterCell.Item]) -> ()) {
        movie.posterCellItems(for: listType, page: page, networkEngine: networkEngine).then { posters in
            completion(posters)
        }
    }

//    func activate_() {
//        let store = SessionStore()
//        store.removeSessionId()
//        guard let sessionId = store.sessionId else {
//            DispatchQueue.main.async {
//                let sessionService = SessionRenewalService(tmdb: self.tmdb) { sessionId in
//                    store.setSessionId(sessionId)
//                    print("session id retrieved: \(sessionId)")
//                    self.navigationController.dismiss(animated: true)
//                }
//                sessionService.present(with: self.navigationController)
//            }
//            return
//        }
//        print("session id present: \(sessionId)")
//    }
//}

}

