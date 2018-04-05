import UIKit

extension MovieDetails {
    public final class OverviewCell: UICollectionViewCell {

        public func setOverview(_ overview: String?) {
            overviewLabel.text = overview
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(overviewLabel)
            contentView.topAnchor.constraint(equalTo: overviewLabel.topAnchor)
            contentView.leadingAnchor.constraint(equalTo: overviewLabel.leadingAnchor, constant: -15)
            contentView.trailingAnchor.constraint(equalTo: overviewLabel.trailingAnchor, constant: -15)
            contentView.bottomAnchor.constraint(equalTo: overviewLabel.bottomAnchor)
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private let textColor = UIColor.white

        private lazy var overviewLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
            label.textColor = textColor
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            return label
        }()

    }
}
