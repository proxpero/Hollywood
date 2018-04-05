//import UIKit
//import TMDbAPI
//import Promises
//import UtilityKit
//
//extension MovieDetails {
//    final class DataSource: NSObject, UICollectionViewDataSource {
//
//        private let movieId: Id
//        private let movie: TMDb.Movie
//        private let networkEngine: NetworkEngine
//
//        var sections: [SectionType] = []
//
//        public init(movieId: Id, movie: TMDb.Movie, networkEngine: NetworkEngine) {
//            self.movieId = movieId
//            self.movie = movie
//            self.networkEngine = networkEngine
//            super.init()
//
//            let details = networkEngine.load(movie.details(for: movieId))
//            let credits = networkEngine.load(movie.credits(for: movieId))
//
//            all(details, credits).then { details, credits in
//                self.sections = []
//            }
//
//        }
//
//        public func numberOfSections(in collectionView: UICollectionView) -> Int {
//            return sections.count
//        }
//
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            let section = sections[section]
//            return section.rowCount
//        }
//
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let section = sections[indexPath.section]
//            fatalError()
//        }
//
//
//
//
//
//
//
//    }
//}
