import Foundation
import Promises
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension URLSession {

    public enum Error: Swift.Error {
        case invalid
    }

    public func dataTask(with request: URLRequest) -> Promise<(data: Data, response: URLResponse)> {
        return Promise { fulfill, reject in
            self.dataTask(with: request) { (data, response, error) in
                if let data = data, let response = response {
                    fulfill((data, response))
                } else if let error = error {
                    reject(error)
                } else {
                    reject(URLSession.Error.invalid)
                }
            }.resume()
        }
    }

    public func dataTask(with url: URL) -> Promise<(data: Data, response: URLResponse)> {
        let request = URLRequest(url: url)
        return dataTask(with: request)
    }
}

let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4559e8696247b2066f5ab358314210d1&page=1")!
let url2 = URL(string: "http://www.fakeresponse.com/api/?sleep=5")!
let request = URLRequest(url: url)

func again() {
    let t3 = Date()
    URLSession.shared.dataTask(with: request).then { (data, response) in
        let t4 = Date()
        print(t4.timeIntervalSince(t3))
        PlaygroundPage.current.finishExecution()
    }

}


let t1 = Date()
URLSession.shared.dataTask(with: request).then { (data, response) in
    let t2 = Date()
    print(t2.timeIntervalSince(t1))
    again()
}

