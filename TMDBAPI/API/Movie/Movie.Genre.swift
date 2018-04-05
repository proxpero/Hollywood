public extension TMDb.Movie {

    enum Genre: Int {
        case adventure = 12
        case romance = 10749
        case scienceFiction = 878
        case fantasy = 14
        case horror = 27
        case mystery = 9648
        case documentary = 99
        case western = 37
        case animation = 16
        case tvMovie = 10770
        case music = 10402
        case action = 28
        case drama = 18
        case thriller = 53
        case history = 36
        case family = 10751
        case war = 10752
        case comedy = 35
        case crime = 80

        var title: String {
            switch self {
            case .adventure: return "Adventure"
            case .romance: return "Romance"
            case .scienceFiction: return "Science Fiction"
            case .fantasy: return "Fantasy"
            case .horror: return "Horror"
            case .mystery: return "Mystery"
            case .documentary: return "Documentary"
            case .western: return "Western"
            case .animation: return "Animation"
            case .tvMovie: return "TV Movie"
            case .music: return "Music"
            case .action: return "Action"
            case .drama: return "Drama"
            case .thriller: return "Thriller"
            case .history: return "History"
            case .family: return "Family"
            case .war: return "War"
            case .comedy: return "Comedy"
            case .crime: return "Crime"
            }
        }
    }

    struct GenreResultObject: Decodable {
        let id: Int
        let name: String

        var genre: Genre? {
            return Genre.init(rawValue: id)
        }
    }
}
