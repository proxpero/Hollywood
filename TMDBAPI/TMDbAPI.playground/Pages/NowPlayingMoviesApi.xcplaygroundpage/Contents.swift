import TMDbAPI
import UtilityKit
import BoxOffice
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)
let resource = Resource<TMDb.Movie.List>(url: movie.nowPlayingUrl())

URLSession.shared.load(resource).then { list in
    list.resultObjects
    }.then { objects in
        objects.enumerated().forEach { print("\($0.offset + 1)\t\($0.element.title)") }
        PlaygroundPage.current.finishExecution()
}


