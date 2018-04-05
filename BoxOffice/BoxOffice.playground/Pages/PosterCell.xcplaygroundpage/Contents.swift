import BoxOffice
import TMDbAPI
import UtilityKit
import Promises
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
typealias DetailResultObject = TMDb.Movie.DetailResultObject

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)

let width: CGFloat = 185
let size = CGSize(width: width, height: width*1.5)
let frame = CGRect(origin: CGPoint.zero, size: size)
let posterCell = PosterCell(frame: frame)

let session = URLSession.ephemeral

let isleOfDogsId = 399174
session.load(movie.details(for: isleOfDogsId)).then { object -> Promise<UIImage> in
    let imageUrl = object.posterImage?.url(size: .w500)
    print(imageUrl!)
    let resource = Resource<UIImage>(url: imageUrl!, parse: UIImage.init)
    posterCell.setTitle(object.title)
    return session.load(resource)
}.then { image in
    posterCell.setImage(image)
}

let parent = UIView(frame: frame)
parent.backgroundColor = .red
parent.addSubview(posterCell)

PlaygroundPage.current.liveView = parent

