import TMDbAPI
import UIKit

public protocol SectionType {
    var headerView: UICollectionReusableView { get }
    var headerViewHeight: CGFloat { get }
    var rowCount: Int { get }
    func height(for row: Int, width: CGFloat) -> CGFloat
}

extension SectionType {
    public var headerView: UICollectionReusableView { return UICollectionReusableView() }
    public var headerViewHeight: CGFloat { return 0 }
}

extension MovieDetails.ViewController {

    public struct Main: SectionType {

        let title: String
        let director: String
        let year: String
        let overview: String
        let runtime: String
        var poster: Resource<UIImage>?
        var backdrop: Resource<UIImage>?

        init(details: TMDb.Movie.DetailResultObject, credits: TMDb.Movie.CreditsObject) {
            self.title = details.title
            self.director = credits.director
            self.year = details.year
            self.overview = details.overview
            self.runtime = "\(details.runtime) minutes"
            if let image = details.posterImage {
                let url = image.url(size: .w185)
                self.poster = Resource<UIImage>(url: url, parse: UIImage.init)
            }
            if let image = details.backdropImage {
                let url = image.url(size: .w780)
                self.backdrop = Resource<UIImage>(url: url, parse: UIImage.init)
            }
        }

        public var rowCount: Int { return 1 }

        public func height(for row: Int, width: CGFloat) -> CGFloat {
            let headerHeight: CGFloat = width * 0.5625
            let infoHeight: CGFloat = 153
            return headerHeight + infoHeight
        }

    }

    public struct Credits: SectionType {

        public var headerView: UIView? {
            return MovieDetails.CreditsHeaderView(frame: .zero)
        }
        public var headerViewHeight: CGFloat { return 50 }

        public var rowCount: Int { return 0 }

        public func height(for row: Int, width: CGFloat) -> CGFloat {
            return 0
        }

    }

    public struct Dummy: SectionType {
        public var rowCount: Int = 20

        public func height(for row: Int, width: CGFloat) -> CGFloat {
            return 44
        }

    }
}

