import UIKit
import BoxOffice
import Promises
import TMDbAPI
import UtilityKit

typealias DetailResultObject = TMDb.Movie.DetailResultObject

final class ScratchViewController: UIViewController {

    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x171B20)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
        let movie = TMDb.Movie(api: tmdb)
        let networkEngine: NetworkEngine = URLSession.shared

        let width = view.frame.width
        let headerHeight = width * 0.5625
        let infoHeight = width * 0.3846153846
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: headerHeight + infoHeight))

        let isleOfDogsId = 399174
        let mainCell = MovieDetails.MainCell(frame: frame)
//        mainCell.translatesAutoresizingMaskIntoConstraints = false
//        mainCell.heightAnchor.constraint(equalToConstant: headerHeight + infoHeight).isActive = true
        let details = networkEngine.load(movie.details(for: isleOfDogsId))
        let credits = networkEngine.load(movie.credits(for: isleOfDogsId))

        func setPoster(url: URL) {
            let resource = Resource<UIImage>(url: url, parse: UIImage.init)
            networkEngine.load(resource).then { image in
                mainCell.setPosterImage(image)
            }
        }

        func setBackdrop(url: URL) {
            let resource = Resource<UIImage>(url: url, parse: UIImage.init)
            networkEngine.load(resource).then { image in
                mainCell.setBackdropImage(image)
            }
        }

        details.then { object in
            mainCell.setTitle(object.title)
            mainCell.setYear(object.year)
            mainCell.setOverview(object.overview)
            mainCell.setRunningTime("\(object.runtime) minutes")
            setPoster(url: object.posterImage!.url(size: .w185))
            setBackdrop(url: object.backdropImage!.url(size: .w780))
        }

        credits.then { object in
            mainCell.setDirector(object.director)
        }

        view.addSubview(mainCell)
//        NSLayoutConstraint.activate([
//            view.bottomAnchor.constraint(equalTo: mainCell.bottomAnchor),
//            view.leadingAnchor.constraint(equalTo: mainCell.leadingAnchor),
//            view.trailingAnchor.constraint(equalTo: mainCell.trailingAnchor)
//        ])
        mainCell.setInitialTransform(scale: 1.2)
    }

}

extension TMDb.Movie.DetailResultObject {
    var year: String {
        let year = Calendar.current.component(.year, from: releaseDate)
        return String(year)
    }
}
