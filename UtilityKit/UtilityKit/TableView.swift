import UIKit

extension UITableView {

    public func dequeue<A: UITableViewCell>(_ cellType: A.Type, for indexPath: IndexPath) -> A {
        let identifier = A.cellReuseIdentifier
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? A else {
            fatalError("Could not create a cell from type \(A.self)")
        }
        return cell
    }

}

extension UITableViewCell {

    public static var cellReuseIdentifier: String {
        return "\(self)"
    }

}
