import XCTest
import UtilityKit
import Promises

@testable import TMDbAPI

typealias Movie = TMDb.Movie

class ResourceTests: XCTestCase {

    var movie: Movie!
    var session: URLSession!

    override func setUp() {
        movie = Movie(
            api: TMDb(
                baseUrl: Bundle(for: ResourceTests.self)
                    .url(forResource: "Resources", withExtension: "bundle")!
                    .appendingPathComponent("json"),
                apiKey: "abc123"
            )
        )
        session = URLSession(configuration: URLSessionConfiguration.ephemeral)
    }

    func testPopularListResource() {
        let expect = expectation(description: "LoadResourcePromise")
        let url = movie.popularUrl()
        let resource = Resource<Movie.List>(url: url)
        session.load(resource).then { list in
            let objects = list.resultObjects
            XCTAssertEqual(objects.count, 20)
            expect.fulfill()
        }
        waitForExpectations(timeout: 0.05)
    }

    func testUpcomingListResource() {
        let expect = expectation(description: "LoadResourcePromise")
        let url = movie.upcomingUrl()
        let resource = Resource<Movie.List>(url: url)
        session.load(resource).then { list in
            let objects = list.resultObjects
            XCTAssertEqual(objects.count, 20)
            expect.fulfill()
        }
        waitForExpectations(timeout: 0.05)
    }

    func testTopRatedListResource() {
        let expect = expectation(description: "LoadResourcePromise")
        let url = movie.topRatedUrl()
        let resource = Resource<Movie.List>(url: url)
        session.load(resource).then { list in
            let objects = list.resultObjects
            XCTAssertEqual(objects.count, 20)
            expect.fulfill()
        }
        waitForExpectations(timeout: 0.05)
    }

    func testNowPlayingListResource() {
        let expect = expectation(description: "LoadResourcePromise")
        let url = movie.nowPlayingUrl()
        let resource = Resource<Movie.List>(url: url)
        session.load(resource).then { list in
            let objects = list.resultObjects
            XCTAssertEqual(objects.count, 20)
            expect.fulfill()
        }
        waitForExpectations(timeout: 0.05)
    }

    func testDetailsResource() {
        let expect = expectation(description: "LoadResourcePromise")
        let url = movie.detailsUrl(for: 399174)
        let resource = Resource<Movie.DetailResultObject>(url: url)
        session.load(resource).then { object in
            XCTAssertEqual(object.id, 399174)
            expect.fulfill()
        }
        waitForExpectations(timeout: 0.05)

    }

}
