//
//  TvTests.swift
//  TMDbAPITests
//
//  Created by Todd Olsen on 3/25/18.
//

import XCTest
@testable import TMDbAPI

typealias Tv = TMDb.Tv

class TvTests: XCTestCase {

    var baseUrl: URL!
    var apiKey = "abc123"
    var tv: Tv!
    var session: URLSession!

    override func setUp() {

        baseUrl = Bundle(for: ResourceTests.self)
            .url(forResource: "Resources", withExtension: "bundle")!
            .appendingPathComponent("json")

        tv = Tv(api: TMDb(
            baseUrl: baseUrl,
            apiKey: apiKey,
            language: .en,
            region: .us,
            sessionId: nil
            )
        )

        session = URLSession.ephemeral
    }

    func testTvDetailsUrl() {
        let tvId = 68595
        let result = tv.detailsUrl(for: tvId)
        let expectation = "\(baseUrl.absoluteString)/tv/\(tvId)?api_key=\(apiKey)"
        XCTAssertEqual(result.absoluteString, expectation)
    }

    func testDecodeTvGenres() {
        let json = """
        [{"id":99,"name":"Documentary"},{"id":10751,"name":"Family"}]
        """
        let result = try! JSONDecoder().decode([TMDb.Tv.GenreResultObject].self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.map { $0.id }.contains(99))
        XCTAssertTrue(result.map { $0.id }.contains(10751))
        XCTAssertEqual(result.compactMap { $0.genre }.count, 2)
    }

    func testTvDetails() {
        let json = """
        {"backdrop_path":"/xIt4DDYipMPNu2HDBrhUS4ndSYb.jpg","created_by":[],"episode_run_time":[60],"first_air_date":"2016-11-06","genres":[{"id":99,"name":"Documentary"},{"id":10751,"name":"Family"}],"homepage":"http://www.bbc.co.uk/programmes/p02544td","id":68595,"in_production":false,"languages":["en"],"last_air_date":"2016-12-11","name":"Planet Earth II","networks":[{"name":"BBC One","id":4,"logo_path":"/mVn7xESaTNmjBUyUtGNvDQd3CT1.png","origin_country":"GB"}],"number_of_episodes":6,"number_of_seasons":1,"origin_country":["GB"],"original_language":"en","original_name":"Planet Earth II","overview":"David Attenborough presents a documentary series exploring how animals meet the challenges of surviving in the most iconic habitats on earth.","popularity":16.917534,"poster_path":"/uy5QoTu8fc6fGXMCTMbpQJFUEB0.jpg","production_companies":[{"id":11795,"logo_path":null,"name":"France Télévisions","origin_country":""},{"id":21404,"logo_path":null,"name":"ZDF","origin_country":""},{"id":9050,"logo_path":null,"name":"BBC Natural History Unit","origin_country":""},{"id":80893,"logo_path":null,"name":"BBC Studios","origin_country":""},{"id":4606,"logo_path":null,"name":"Zweites Deutsches Fernsehen (ZDF)","origin_country":""},{"id":5996,"logo_path":null,"name":"BBC","origin_country":""}],"seasons":[{"air_date":"2016-12-05","episode_count":3,"id":83286,"name":"Specials","overview":"","poster_path":"/faJBZbQP1d4jzsEp8YQ9awhv5F6.jpg","season_number":0},{"air_date":"2016-11-06","episode_count":6,"id":81788,"name":"Season 1","overview":"","poster_path":"/uy5QoTu8fc6fGXMCTMbpQJFUEB0.jpg","season_number":1}],"status":"Ended","type":"Miniseries","vote_average":8.6,"vote_count":195}
        """
        let result = try! JSONDecoder().decode(TMDb.Tv.DetailResultObject.self, from: json.data(using: .utf8)!)
        XCTAssertEqual(result.id, 68595)
        XCTAssertEqual(result.name, "Planet Earth II")
    }

    func testDecodeTvList() {
        let url = tv.popularUrl()
        let json = try! String.init(contentsOf: url)
        let data = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(TMDb.Tv.List.self, from: data)
        XCTAssertEqual(result.resultObjects.count, 20)
    }

    func testTvListLoadResource() {
        let expect = expectation(description: "Load popular list result objects.")
        session.load(tv.popular()).then { objects in
            XCTAssertEqual(objects.count, 20)
            expect.fulfill()
        }
        waitForExpectations(timeout: 0.05)
    }
}
