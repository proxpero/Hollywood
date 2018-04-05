import UIKit
import UtilityKit

extension MovieDetails {
    public final class CreditsHeaderView: UICollectionReusableView {

        public var didSelectCreditType: (CreditType) -> () = { _ in }

        private lazy var segmentedControl: UISegmentedControl = {
            let control = UISegmentedControl(frame: .zero)
            control.translatesAutoresizingMaskIntoConstraints = false
            for credit in CreditType.all {
                control.insertSegment(withTitle: credit.title, at: credit.rawValue, animated: true)
            }
            control.selectedSegmentIndex = 0
            control.addTarget(self, action: #selector(segmentSelectedAction(sender:)), for: .valueChanged)
            control.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.white], for: .selected)
            return control
        }()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(segmentedControl)
            self.constrainEdges(to: segmentedControl, insets: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        @objc private func segmentSelectedAction(sender: UISegmentedControl) {
            let index = sender.selectedSegmentIndex
            guard let selection = CreditType(rawValue: index) else { return }
            didSelectCreditType(selection)
        }
        
        public enum CreditType: Int {
            case cast = 0
            case crew = 1
            case studio = 2
            case genres = 3
            
            var title: String {
                switch self {
                case .cast: return "Cast"
                case .crew: return "Crew"
                case .studio: return "Studio"
                case .genres: return "Genres"
                }
            }
            
            static var all: [CreditType] {
                return [.cast, .crew, .studio, .genres]
            }
        }
        
    }
}
