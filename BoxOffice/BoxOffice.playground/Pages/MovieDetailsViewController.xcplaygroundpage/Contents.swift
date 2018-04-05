import BoxOffice
import TMDbAPI
import Promises
import UtilityKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let tmdb = TMDb(baseUrl: URL(string: "https://api.themoviedb.org/3")!, apiKey: "4559e8696247b2066f5ab358314210d1")
let movie = TMDb.Movie(api: tmdb)
let networkEngine: NetworkEngine = URLSession.ephemeral

let header = MovieDetailsViewController.Section(
    headerView: nil,
    headerViewHeight: 0,
    rowCount: 1,
    rowHeight: { _ in 100 },
    cell: { collectionView, indexPath in
        let image = #imageLiteral(resourceName: "IsleOfDogs.jpg")
        let cell = collectionView.dequeueReusableCell(MovieDetailsBackdropCell.self, for: indexPath)
        cell.headerImage.image = image
        return cell
    },
    register: { _ in }
)


let info = MovieDetailsViewController.Section(
    headerView: nil,
    headerViewHeight: 0,
    rowCount: 1,
    rowHeight: { _ in 92 },
    cell: { collectionView, indexPath in
        let cell = collectionView.dequeueReusableCell(MovieDetailsInfoCell.self, for: indexPath)
        let title = "Zootopia"
        let poster = #imageLiteral(resourceName: "IsleOfDogsPoster.jpg")
        let year = "2016"
        let director = "Bryan Howard, Rich Moore"
        let runningTime = "108"

        cell.setPosterImage(poster)
        cell.setTitle(title)
        cell.setYear(year)
        cell.setDirector(director)
        cell.setRunningTime(runningTime)

        return cell
    },
    register: { _ in }
)

let last = MovieDetailsViewController.Section(
    headerView: nil,
    headerViewHeight: 0,
    rowCount: 30,
    rowHeight: { _ in 44 },
    cell: { collectionView, indexPath in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegularCell", for: indexPath) as! RegularCell
        return cell
    },
    register: { tableView in
        tableView.register(RegularCell.self)
    }
)

let vc = MovieDetailsViewController()
vc.sections = [header, info, last]
let parent = UIViewController(
    child: vc,
    device: .phone4inch,
    orientation: .portrait,
    contentSizeCategory: .large)
PlaygroundPage.current.liveView = parent

