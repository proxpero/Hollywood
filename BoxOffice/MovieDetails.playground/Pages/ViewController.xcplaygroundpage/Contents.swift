import BoxOffice
import TMDbAPI
import Promises
import UtilityKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)
let networkEngine: NetworkEngine = URLSession.shared

