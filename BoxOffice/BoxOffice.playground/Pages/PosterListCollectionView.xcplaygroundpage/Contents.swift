import BoxOffice
import TMDbAPI
import Promises
import UtilityKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)
let networkEngine: NetworkEngine = URLSession.ephemeral

let frame = CGRect(x: 0, y: 0, width: 400, height: 92*1.5 * 4)
let parent = UIView(frame: frame)
parent.backgroundColor = .darkGray

let listTypes: [TMDb.Movie.ListType] = [
    .popular,
    .topRated,
    .upcoming,
    .nowPlaying
]
let items = listTypes.map { movie.posterListItems(for: $0, page: 1, networkEngine: networkEngine) }

let collectionView = PosterListCollectionView()
collectionView.setItems(items)
collectionView.translatesAutoresizingMaskIntoConstraints = false
collectionView.networkEngine = URLSession.shared
collectionView.didSelectListAtIndex = { index in
    let listType = listTypes[index]
    print(listType)
}
collectionView.didSelectPosterCellItem = { item in
    print(item.title)
}
parent.addSubview(collectionView)
parent.constrainEdges(to: collectionView)
//collectionView.setItems(items)

PlaygroundPage.current.liveView = parent

