import Foundation
import UtilityKit

extension URLQueryItem: Codable {

    enum CodingKeys: String, CodingKey {
        case name
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: CodingKeys.name)
        let value = try container.decodeIfPresent(String.self, forKey: CodingKeys.value)
        self.init(name: name, value: value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: CodingKeys.name)
        try container.encodeIfPresent(value, forKey: CodingKeys.value)
    }
}

extension Array where Element == URLQueryItem {
    init(apiKey: String, page: Int, language: Language, region: Region) {
        let queries: [QueryType] = [
            .apiKey(apiKey),
            .language(language),
            .page(page),
            .region(region)
        ]
        self = queries.map { $0.item }
    }
}

extension Date {
    init?(string: String, dateFormatter: DateFormatter) {
        guard let date = dateFormatter.date(from: string) else { return nil }
        self = date
    }
}
