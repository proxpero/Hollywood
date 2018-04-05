import Foundation

extension TMDb.Movie {

    public struct CreditsObject: Decodable {

        public struct CastMember: Decodable {
            public let id: Id
            public let creditId: String
            public let name: String
            public let profile: Image<Profile>?
            public let castId: Id
            public let character: String

            private enum CodingKeys: String, CodingKey {
                case id
                case creditId = "credit_id"
                case name
                case profilePath = "profile_path"
                case castId = "cast_id"
                case character
            }

            public init(from decoder: Decoder) throws {
                guard
                    let container = try? decoder.container(keyedBy: CodingKeys.self),
                    let id = try? container.decode(Int.self, forKey: .id),
                    let creditId = try? container.decode(String.self, forKey: .creditId),
                    let name = try? container.decode(String.self, forKey: .name),
                    let profilePath = try? container.decodeIfPresent(String.self, forKey: .profilePath),
                    let castId = try? container.decode(Int.self, forKey: .castId),
                    let character = try? container.decode(String.self, forKey: .character)
                else { throw TMDbError.Movie.decoding }

                self.id = id
                self.creditId = creditId
                self.name = name
                self.profile = Image<Profile>(path: profilePath)
                self.castId = castId
                self.character = character
            }
        }

        public struct CrewMember: Decodable {
            public let id: Id
            public let creditId: String
            public let name: String
            public let profile: Image<Profile>?
            public let job: String
            public let department: String

            private enum CodingKeys: String, CodingKey {
                case id
                case creditId = "credit_id"
                case name
                case profilePath = "profile_path"
                case job
                case department
            }

            public init(from decoder: Decoder) throws {
                guard
                    let container = try? decoder.container(keyedBy: CodingKeys.self),
                    let id = try? container.decode(Int.self, forKey: .id),
                    let creditId = try? container.decode(String.self, forKey: .creditId),
                    let name = try? container.decode(String.self, forKey: .name),
                    let profilePath = try? container.decodeIfPresent(String.self, forKey: .profilePath),
                    let job = try? container.decode(String.self, forKey: .job),
                    let department = try? container.decode(String.self, forKey: .department)
                else { throw TMDbError.Movie.decoding }

                self.id = id
                self.creditId = creditId
                self.name = name
                self.profile = Image<Profile>(path: profilePath)
                self.job = job
                self.department = department
            }
        }

        public let id: Id
        public let cast: [CastMember]
        public let crew: [CrewMember]

        public var director: String {
            return crew
                .filter { $0.job == "Director" }
                .map { $0.name }.joined(separator: ", ")
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case cast
            case crew
        }

        public init(from decoder: Decoder) throws {
            guard
                let container = try? decoder.container(keyedBy: CodingKeys.self),
                let id = try? container.decode(Int.self, forKey: .id),
                let cast = try? container.decode([CastMember].self, forKey: .cast),
                let crew = try? container.decode([CrewMember].self, forKey: .crew)
            else { throw TMDbError.Movie.decoding }
            
            self.id = id
            self.cast = cast
            self.crew = crew
        }
    }
}
