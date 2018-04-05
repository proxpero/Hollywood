import BoxOffice
import TMDbAPI
import UtilityKit
import Promises
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
typealias DetailResultObject = TMDb.Movie.DetailResultObject

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)
let networkEngine: NetworkEngine = URLSession.ephemeral

let frame = CGRect(x: 0, y: 0, width: 400, height: 92*1.5)
let parent = UIView(frame: frame)
parent.backgroundColor = .darkGray

let collectionView = PosterImagesCollectionView(networkEngine: networkEngine)
collectionView.translatesAutoresizingMaskIntoConstraints = false
collectionView.didSelectItem = { item in
    print(item.title)
}
parent.addSubview(collectionView)
parent.constrainEdges(to: collectionView)

PlaygroundPage.current.liveView = parent

networkEngine.load(movie.popular()).then { objects in
    collectionView.items = objects.map(PosterCell.Item.init)
    collectionView.reloadData()
}


