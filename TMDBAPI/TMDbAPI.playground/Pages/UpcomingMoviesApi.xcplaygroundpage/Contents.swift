import TMDbAPI
import UtilityKit
import BoxOffice
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)

let url1 = movie.upcomingUrl()
let url2 = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=4559e8696247b2066f5ab358314210d1&language=en&page=1&region=US")!

print(url1.absoluteString)
print(url2.absoluteString)

let resource = Resource<TMDb.Movie.List>(url: url1)

URLSession.ephemeral.load(resource).then { list in
    list.resultObjects
}.then { objects in
    objects.enumerated().forEach { print("\($0.offset + 1)\t\($0.element.title) (\($0.element.popularity))") }
    PlaygroundPage.current.finishExecution()
}

