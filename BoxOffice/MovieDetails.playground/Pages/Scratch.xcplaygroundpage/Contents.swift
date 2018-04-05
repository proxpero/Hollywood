import BoxOffice
import TMDbAPI
import Promises
import UtilityKit
import PlaygroundSupport

struct Main {
    let poster: Image<Poster>?
    let backdrop: Image<Backdrop>?
    let title: String
    let director: String
    let year: String
}

final class MainCell: UITableViewCell {}

extension Main {
    func configureCell(_ cell: MainCell) {
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = director
    }
}

struct Overview {
    let value: String
}

final class OverviewCell: UITableViewCell {}

extension Overview {
    func configureCell(_ cell: OverviewCell) {
        cell.textLabel?.text = value
    }

}

enum SectionType {
    case main(Main)
    case overview(Overview)
}

struct SectionDescriptor {

    struct Header {
        let view: UIView
        let height: CGFloat
    }

    struct CellDescriptor {
        let cellClass: UITableViewCell.Type
        let reuseIdentifier: String
        let configure: (UITableViewCell) -> ()

        init<Cell: UITableViewCell>(reuseIdentifier: String, configure: @escaping (Cell) -> ()) {
            self.cellClass = Cell.self
            self.reuseIdentifier = reuseIdentifier
            self.configure = { cell in
                configure(cell as! Cell)
            }
        }
    }

    let rowCount: Int
    let cellDescriptor: CellDescriptor
    let header: Header?

    init(rowCount: Int, cellDescriptor: CellDescriptor, header: Header? = nil) {
        self.rowCount = rowCount
        self.cellDescriptor = cellDescriptor
        self.header = header
    }

}

extension SectionType {
    var section: SectionDescriptor {
        switch self {
        case .main(let value):
            return SectionDescriptor(
                rowCount: 1,
                cellDescriptor: SectionDescriptor.CellDescriptor(
                    reuseIdentifier: "MainCell",
                    configure: value.configureCell),
                header: nil)
        case .overview(let value):
            return SectionDescriptor(
                rowCount: 1,
                cellDescriptor: SectionDescriptor.CellDescriptor(
                    reuseIdentifier: "OverviewCell",
                    configure: value.configureCell)
            )
        default:
            fatalError()
        }
    }
}

let isleOfDogsMain = Main(poster: nil, backdrop: nil, title: "Isle of Dogs", director: "Wes Anderson", year: "2018")
let isleOfDogsOverview = Overview(value: "A bunch of dogs.")
//let sections: [SectionType] = [
//    .main(isleOfDogsMain),
//    .overview(isleOfDogsOverview)
//]

final class ViewController: UIViewController {

    var sections: [SectionType] = [] {
        didSet {
            guard let tableView = view as? UITableView else { return }
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }

    override func loadView() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainCell.self, forCellReuseIdentifier: "MainCell")
        tableView.register(OverviewCell.self, forCellReuseIdentifier: "OverviewCell")
        view = tableView
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionDescriptor = sections[section].section
        return sectionDescriptor.rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionDescriptor = sections[indexPath.section].section
        let cellDescriptor = sectionDescriptor.cellDescriptor
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDescriptor.reuseIdentifier, for: indexPath)
        cellDescriptor.configure(cell)
        return cell
    }

}

let vc = ViewController(nibName: nil, bundle: nil)
vc.sections = [
    .main(isleOfDogsMain),
    .overview(isleOfDogsOverview)
]

let nc = UINavigationController(rootViewController: vc)
nc.view.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
PlaygroundPage.current.liveView = nc.view
