import Foundation
import TMDbAPI
import UtilityKit
import Promises
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let baseURL = URL(string: "https://api.themoviedb.org/3")!
let apiKey = "4559e8696247b2066f5ab358314210d1"

typealias Tv = TMDb.Tv

let tmdb = TMDb(
    baseUrl: baseURL,
    apiKey: apiKey,
    language: .en,
    region: .us,
    sessionId: nil
)

let tv = Tv(api: tmdb)
let networkEngine: NetworkEngine = URLSession.shared

networkEngine.load(tv.details(for: 68595)).then { objects in
    print(objects)
    PlaygroundPage.current.finishExecution()
}

