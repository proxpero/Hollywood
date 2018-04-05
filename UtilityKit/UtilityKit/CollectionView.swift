import UIKit

public extension UICollectionReusableView {

    static var reuseIdentifier: String {
        return "\(self)"
    }
}

public extension UICollectionView {

    enum SupplementaryElementKind {
        case header
        case footer

        public var stringValue: String {
            switch self {
            case .header: return UICollectionElementKindSectionHeader
            case .footer: return UICollectionElementKindSectionFooter
            }
        }
    }

    func register<A: UICollectionViewCell>(_ cellType: A.Type) {
        register(A.self, forCellWithReuseIdentifier: A.reuseIdentifier)
    }

    func register<A: UICollectionReusableView>(_ cellType: A.Type, kind: SupplementaryElementKind) {
        register(A.self, forSupplementaryViewOfKind: kind.stringValue, withReuseIdentifier: A.reuseIdentifier)
    }

    func dequeue<A: UICollectionViewCell>(_ cellType: A.Type, for indexPath: IndexPath) -> A {
        guard let cell = dequeueReusableCell(withReuseIdentifier: A.reuseIdentifier, for: indexPath) as? A else {
            fatalError("Could not create a cell from type \(A.reuseIdentifier)")
        }
        return cell
    }

    func dequeue<A: UICollectionReusableView>(_ cellType: A.Type, kind: SupplementaryElementKind, for indexPath: IndexPath) -> A {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind.stringValue, withReuseIdentifier: A.reuseIdentifier, for: indexPath) as? A else {
            fatalError("Could not create a supplementary view from type \(A.reuseIdentifier)")
        }
        return view
    }

}
