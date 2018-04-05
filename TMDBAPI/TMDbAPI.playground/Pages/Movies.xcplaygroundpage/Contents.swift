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
let networkEngine: NetworkEngine = URLSession.ephemeral

let isleOfDogsId = 399174


//networkEngine.load(movie.details(for: isleOfDogsId)).then { object in
//    print(object)
//    PlaygroundPage.current.finishExecution()
//}

//networkEngine.load(movie.popular()).then { objects in
//    print(objects)
//    PlaygroundPage.current.finishExecution()
//}

networkEngine.load(movie.credits(for: isleOfDogsId)).then { credits in
    print(credits)
    PlaygroundPage.current.finishExecution()
}


