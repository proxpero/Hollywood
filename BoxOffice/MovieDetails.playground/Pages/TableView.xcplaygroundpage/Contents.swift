import UIKit
import TMDbAPI
import Promises
import UtilityKit
import BoxOffice
import PlaygroundSupport

private let travelDistance: CGFloat = 70
private let transitionDistance: CGFloat = 90

protocol RowType {

}

extension MovieDetails {

    public struct Section<A> {

        struct Header {
            var view: UIView
            var height: CGFloat
        }

        var header: Header?
        let rows: [RowType]
        let rowCount: Int
        let configureCell: (UITableViewCell, A)

        func configureCell<A>(cell: UITableViewCell, item: A) {
            cell.backgroundColor = .blue
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            configureCell(cell: cell, item: "Hello")
            return cell
        }
    }

    public final class TableViewController: UIViewController {

        var sections: [Section] = [] {
            didSet {
                guard let tableView = view as? UITableView else { return }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }

        public override func loadView() {
            let tableView = UITableView(frame: .zero, style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            self.view = tableView
        }


    }
}

extension MovieDetails.TableViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header?.height ?? 0
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].header?.view
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rowCount
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }

}

extension String: RowType {}

let section = MovieDetails.Section(
    header: nil,
    rows: ["hello"],
    rowCount: 1
)

let vc = MovieDetails.TableViewController(nibName: nil, bundle: nil)
let parent = UIViewController(child: vc)
PlaygroundPage.current.liveView = parent

vc.sections = [section]

