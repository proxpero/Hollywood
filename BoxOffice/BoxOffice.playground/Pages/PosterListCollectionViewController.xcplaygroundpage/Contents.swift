import BoxOffice
import TMDbAPI
import Promises
import UtilityKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)
let networkEngine: NetworkEngine = URLSession.ephemeral

let listTypes: [TMDb.Movie.ListType] = [
    .popular,
    .topRated,
    .upcoming,
    .nowPlaying
]
let items = listTypes.map { movie.posterListItems(for: $0, page: 1, networkEngine: networkEngine) }

let vc = PosterListCollectionViewController(nibName: nil, bundle: nil)
vc.view.backgroundColor = .darkGray
vc.networkEngine = networkEngine
vc.setItems(items)

vc.didSelectPosterCellItem = { item in
    print("Did select item \(item)")
}

vc.didSelectListAtIndex = { index in
    print("Did select index \(index)")
}

let parent = UIViewController(child: vc, device: .phone4inch, orientation: .portrait, contentSizeCategory: .medium)
PlaygroundPage.current.liveView = parent

