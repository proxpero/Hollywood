import UIKit

extension MovieDetails {
    public final class InfoCell: UICollectionViewCell {

        public func setPosterImage(_ image: UIImage?) {
            posterImageView.image = image
        }

        public func setTitle(_ title: String?) {
            titleLabel.text = title
        }

        public func setYear(_ year: String?) {
            yearLabel.text = year
        }

        public func setDirector(_ director: String?) {
            directorLabel.text = director
        }

        public func setRunningTime(_ runningTime: String?) {
            runningTimeLabel.text = runningTime
        }

        public var didTapTrailer: () -> () = {}

        public func setOverview(_ overview: String?) {
            overviewLabel.text = overview
        }

        public func setTitleAlpha(newAlpha: CGFloat) {
            titleLabel.textColor = textColor.withAlphaComponent(newAlpha)
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(titleLabel)
            contentView.addSubview(posterImageView)
            contentView.addSubview(yearLabel)
            contentView.addSubview(directedByLabel)
            contentView.addSubview(directorLabel)
            contentView.addSubview(trailerButton)
            contentView.addSubview(runningTimeLabel)
            contentView.addSubview(overviewLabel)

            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 60),
                contentView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -15),
                contentView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
                titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 15),
                titleLabel.leadingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: yearLabel.topAnchor, constant: -15),
                yearLabel.firstBaselineAnchor.constraint(equalTo: directedByLabel.firstBaselineAnchor),
                yearLabel.trailingAnchor.constraint(equalTo: directedByLabel.leadingAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: directorLabel.leadingAnchor),
                directorLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 3),
                trailerButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                trailerButton.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 15),
                runningTimeLabel.centerYAnchor.constraint(equalTo: trailerButton.centerYAnchor),
                runningTimeLabel.leadingAnchor.constraint(equalTo: trailerButton.trailingAnchor, constant: 15),
//                contentView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 0),
                overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                overviewLabel.topAnchor.constraint(equalTo: trailerButton.bottomAnchor, constant: 15),
                overviewLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
//                overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15)
                ])
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // Private

        private let textColor = UIColor.white

        private lazy var posterImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 2/3).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 92).isActive = true
            imageView.layer.cornerRadius = 6
            imageView.clipsToBounds = true
            return imageView
        }()

        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.textColor = textColor
            return label
        }()

        private lazy var yearLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
            label.textColor = textColor
            return label
        }()

        private lazy var directedByLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = " ▪︎ Directed By".uppercased()
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
            label.textColor = textColor
            return label
        }()

        private lazy var directorLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            label.textColor = textColor
            return label
        }()

        private lazy var runningTimeLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            label.textColor = textColor
            return label
        }()

        private lazy var trailerButton: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
            label.text = "▷ Trailer".uppercased()
            label.textColor = textColor

            label.addGestureRecognizer(UITapGestureRecognizer(
                target: self,
                action: #selector(didTapTrailerButtonAction(sender:)))
            )
            label.textAlignment = .center
            label.heightAnchor.constraint(equalToConstant: 25).isActive = true
            label.widthAnchor.constraint(equalToConstant: 90).isActive = true
            label.layer.cornerRadius = 12
            label.backgroundColor = .gray
            label.clipsToBounds = true
            return label
        }()

        @objc private func didTapTrailerButtonAction(sender: UILabel) {
            print(#function)
            didTapTrailer()
        }

        private lazy var overviewLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
            label.numberOfLines = 3
            label.lineBreakMode = .byWordWrapping
            label.textColor = textColor
            return label
        }()

    }
}
