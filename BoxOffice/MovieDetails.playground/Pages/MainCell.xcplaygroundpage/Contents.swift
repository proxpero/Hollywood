import BoxOffice
import TMDbAPI
import Promises
import UtilityKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)
let networkEngine: NetworkEngine = URLSession.shared

let width: CGFloat = 390
let headerHeight: CGFloat = width * 0.5625
let infoHeight: CGFloat = 153
let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: headerHeight + infoHeight))

let backgroundColor = UIColor(rgb: 0x171B20)

let isleOfDogsId = 399174
let mainCell = MovieDetails.MainCell(frame: frame)

let details = networkEngine.load(movie.details(for: isleOfDogsId))
let credits = networkEngine.load(movie.credits(for: isleOfDogsId))

func setPoster(url: URL) {
    let resource = Resource<UIImage>(url: url, parse: UIImage.init)
    networkEngine.load(resource).then { image in
        mainCell.setPosterImage(image)
    }
}

func setBackdrop(url: URL) {
    let resource = Resource<UIImage>(url: url, parse: UIImage.init)
    networkEngine.load(resource).then { image in
        mainCell.setBackdropImage(image)
    }
}

details.then { object in
    mainCell.setTitle(object.title)
    mainCell.setYear(object.year)
    mainCell.setOverview(object.overview)
    mainCell.setRunningTime("\(object.runtime) minutes")
    setPoster(url: object.posterImage!.url(size: .w185))
    setBackdrop(url: object.backdropImage!.url(size: .w780))
}

credits.then { object in
    mainCell.setDirector(object.director)
}

mainCell.setInitialTransform(scale: 1.2)
mainCell.backgroundColor = backgroundColor

let f = CGRect(origin: CGPoint(x: 0, y: 184.5), size: CGSize(width: 390, height: 35))
let v = UIView(frame: f)
v.backgroundColor = .clear
//let gradient = CAGradientLayer()
//gradient.frame = f
//gradient.colors = [UIColor.clear.cgColor, backgroundColor.cgColor]
//mainCell.layer.insertSublayer(gradient, at: 0)
v
PlaygroundPage.current.liveView = mainCell
