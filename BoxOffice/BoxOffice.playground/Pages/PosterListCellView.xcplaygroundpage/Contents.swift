import BoxOffice
import TMDbAPI
import UtilityKit
import Promises
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
typealias DetailResultObject = TMDb.Movie.DetailResultObject

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)
let session = URLSession.ephemeral

let frame = CGRect(x: 0, y: 0, width: 400, height: 92*1.5 + 30 + 18)

let posterListView = PosterListCellView(frame: .zero)
posterListView.networkEngine = session
posterListView.translatesAutoresizingMaskIntoConstraints = false

let parent = UIView(frame: frame)
parent.backgroundColor = UIColor(rgb: 0x2d2e38)
parent.addSubview(posterListView)
parent.constrainEdges(to: posterListView)
PlaygroundPage.current.liveView = parent

session.load(movie.popular()).then { objects in
    let vm = PosterListCellView.ViewModel(
        title: "Popular",
        posters: objects.map(PosterCell.Item.init)
    )
    posterListView.viewModel = vm
    posterListView.didSelectItem = { item in
        print(item.title)
    }
}
