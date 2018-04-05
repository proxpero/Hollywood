import Foundation
import TMDbAPI
import UtilityKit
import Promises
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let baseURL = URL(string: "https://api.themoviedb.org/3")!
let apiKey = "4559e8696247b2066f5ab358314210d1"

typealias Movie = TMDb.Movie

let tmdb = TMDb(
    baseUrl: baseURL,
    apiKey: apiKey,
    language: .en,
    region: .us,
    sessionId: nil
)

let movie = Movie(api: tmdb)
let networkEngine: NetworkEngine = URLSession.shared

networkEngine.load(movie.popular()).then { objects in
    print(objects)
    let items = objects.map(PosterImageItem.init)
    print(items)
    PlaygroundPage.current.finishExecution()
}
