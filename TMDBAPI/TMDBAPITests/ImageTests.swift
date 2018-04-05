import XCTest
@testable import TMDbAPI

class ImageTests: XCTestCase {

    let baseURL = URL(string: "https://image.example.com/t/p/")!

    func testImageSize() {
        let path = "/myMoviePosterImage.jpg"
        let originalPoster = Image<Poster>(path: path, baseUrl: baseURL)
        let expectation = "https://image.example.com/t/p/original/myMoviePosterImage.jpg"
        XCTAssertNotNil(originalPoster)
        XCTAssertEqual(originalPoster!.url(size: .original).absoluteString, expectation)
    }
    
}
