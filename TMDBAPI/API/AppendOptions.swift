import Foundation

public struct AppendOptions: OptionSet {

    public var rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let images = AppendOptions(rawValue: OptionKey.includeImages.rawValue)
    public static let videos = AppendOptions(rawValue: OptionKey.includeVideos.rawValue)
    public static let all: AppendOptions = [.images, .videos]

    var queryItems: [URLQueryItem] {
        var value = [String]()
        for option in OptionKey.all {
            if self.contains(AppendOptions(rawValue: option.rawValue)) {
                value.append(option.path)
            }
        }
        if value.isEmpty { return [] }
        return [URLQueryItem(name: "append_to_response", value: value.joined(separator: ","))]
    }

    private enum OptionKey: Int {
        case includeImages  = 0b1
        case includeVideos  = 0b10

        var path: String {
            switch self {
            case .includeImages: return "images"
            case .includeVideos: return "videos"
            }
        }

        static var all: [OptionKey] {
            return [.includeImages, .includeVideos]
        }
    }
}
