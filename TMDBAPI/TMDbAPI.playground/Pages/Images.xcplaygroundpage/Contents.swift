import UIKit
import TMDbAPI
import UtilityKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let tmdb = TMDb(
    baseUrl: URL(string: "https://api.themoviedb.org/3")!,
    apiKey: "4559e8696247b2066f5ab358314210d1"
)
let movie = TMDb.Movie(api: tmdb)

let path = "/5YtXsLG9ncjjFyGZjoeV31CGf01.jpg"
let backdrop = Image<Backdrop>(path: path)
let url = backdrop!.url(size: .original)
let resource = Resource<UIImage>(url: url, parse: UIImage.init)
URLSession.ephemeral.load(resource).then { image in
    image
}
