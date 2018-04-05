//import UIKit
//import TMDbAPI
//import Promises
//import UtilityKit
//
//private let travelDistance: CGFloat = 70
//private let transitionDistance: CGFloat = 90
//
//protocol RowType {}
//
//extension MovieDetails {
//
//    struct Section {
//
//        var headerView: UIView?
//        let rows: [RowType]
//        let rowCount: Int
//
//        func configureCell(cell: UITableViewCell, atIndex index: Int) {
//
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = UITableViewCell()
//            configureCell(cell: cell, atIndex: indexPath.row)
//            return cell
//        }
//    }
//
//    public final class TableViewController: UIViewController {
//
//        var sections: [Section] = [] {
//            didSet {
//                guard let tableView = view as? UITableView else { return }
//                DispatchQueue.main.async {
//                    tableView.reloadData()
//                }
//            }
//        }
//
//    }
//}
//
//extension MovieDetails.TableViewController: UITableViewDelegate, UITableViewDataSource {
//
//    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return sections[section].headerView
//    }
//
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sections[section].rowCount
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
//    }
//
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//    }
//
//}
