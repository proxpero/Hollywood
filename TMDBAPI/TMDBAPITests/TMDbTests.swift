import XCTest
import UtilityKit
@testable import TMDbAPI

class TMDbInitTests: XCTestCase {

    let baseUrl = URL(string: "https://api.themoviedb.org/3")!
    let apiKey = "123"

    func testDefaultInitialization() {
        let tmdb = TMDb(baseUrl: baseUrl, apiKey: apiKey)
        XCTAssertEqual(tmdb.baseUrl.absoluteString, baseUrl.absoluteString)
        XCTAssertEqual(tmdb.key, apiKey)
        XCTAssertEqual(tmdb.language, Language.en)
        XCTAssertEqual(tmdb.region, Region.us)
        XCTAssertNil(tmdb.sessionId)
    }

    func testCustomInitialization() {

        let lang = Language.de
        let region = Region.gb
        let sessionId = "secret"

        let tmdb = TMDb(
            baseUrl: baseUrl,
            apiKey: apiKey,
            language: lang,
            region: region,
            sessionId: sessionId
        )
        XCTAssertEqual(tmdb.baseUrl.absoluteString, baseUrl.absoluteString)
        XCTAssertEqual(tmdb.key, apiKey)
        XCTAssertEqual(tmdb.language, lang)
        XCTAssertEqual(tmdb.region, region)
        XCTAssertNotNil(tmdb.sessionId)
        XCTAssertEqual(tmdb.sessionId, sessionId)
    }

    func testSetSessionId() {
        let sessionId = "secret"
        let tmdb = TMDb(baseUrl: baseUrl, apiKey: apiKey)
        XCTAssertNil(tmdb.sessionId)
        tmdb.setSessionId(sessionId)
        XCTAssertNotNil(tmdb.sessionId)
        XCTAssertEqual(tmdb.sessionId, sessionId)
    }
}

class AppendOptionsTests: XCTestCase {

    func testIncludeImages() {
        let includeImages = AppendOptions.images
        XCTAssertEqual(includeImages.rawValue, 0b1)
        XCTAssertEqual(includeImages.queryItems.count, 1)
        XCTAssertEqual(includeImages.queryItems[0].value, "images")
        let expectation = URLQueryItem(name: "append_to_response", value: "images")
        XCTAssertEqual(includeImages.queryItems[0], expectation)
    }

    func testIncludeVideos() {
        let includeVideos = AppendOptions.videos
        XCTAssertEqual(includeVideos.rawValue, 0b10)
        XCTAssertEqual(includeVideos.queryItems.count, 1)
        XCTAssertEqual(includeVideos.queryItems[0].value, "videos")
        let expectation = URLQueryItem(name: "append_to_response", value: "videos")
        XCTAssertEqual(includeVideos.queryItems[0], expectation)
    }

    func testIncludeImagesAndVideos() {
        let includeImagesAndVideos = AppendOptions.all
        XCTAssertEqual(includeImagesAndVideos.rawValue, 0b11)
        XCTAssertEqual(includeImagesAndVideos.queryItems.count, 1)
        let value = includeImagesAndVideos.queryItems[0].value
        XCTAssertNotNil(value)
        XCTAssertTrue(value!.contains("images"))
        XCTAssertTrue(value!.contains("videos"))
        let expectation = URLQueryItem(name: "append_to_response", value: "images,videos")
        XCTAssertEqual(includeImagesAndVideos.queryItems[0], expectation)
    }
}


