import UIKit
import UtilityKit

extension MovieDetails {
    public final class MainCell: UICollectionViewCell {

        public func setBackdropImage(_ image: UIImage?) {
            backdropImageView_.image = image
        }

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

        public func setInitialTransform(scale: CGFloat) {
            backdropImageView_.transform = CGAffineTransform.init(scaleX: scale, y: scale)
        }

//        public func setGradient() {
//            let gradient = CAGradientLayer()
//            gradient.frame = shadowView.frame
//            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//            shadowView.layer.insertSublayer(gradient, at: 0)
//            print(shadowView.frame)
//        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            backdropContainerView.addSubview(backdropImageView_)
            backdropContainerView.addSubview(shadowView)
            contentView.addSubview(backdropContainerView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(posterImageView)
            contentView.addSubview(yearLabel)
            contentView.addSubview(directedByLabel)
            contentView.addSubview(directorLabel)
            contentView.addSubview(trailerButton)
            contentView.addSubview(runningTimeLabel)
            contentView.addSubview(overviewLabel)

            contentView.sendSubview(toBack: backdropContainerView)

            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: backdropContainerView.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: backdropContainerView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: backdropContainerView.trailingAnchor),
                backdropContainerView.widthAnchor.constraint(equalTo: backdropContainerView.heightAnchor, multiplier: 1.777777),
                backdropContainerView.bottomAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 50),
                backdropContainerView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
                backdropContainerView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
                backdropContainerView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -20),
                contentView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
                titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 15),
                titleLabel.leadingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: yearLabel.topAnchor, constant: -8),
                yearLabel.firstBaselineAnchor.constraint(equalTo: directedByLabel.firstBaselineAnchor),
                yearLabel.trailingAnchor.constraint(equalTo: directedByLabel.leadingAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: directorLabel.leadingAnchor),
                directorLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 3),
                trailerButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                trailerButton.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 15),
                runningTimeLabel.centerYAnchor.constraint(equalTo: trailerButton.centerYAnchor),
                runningTimeLabel.leadingAnchor.constraint(equalTo: trailerButton.trailingAnchor, constant: 15),
                overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                overviewLabel.topAnchor.constraint(equalTo: trailerButton.bottomAnchor, constant: 15),
                overviewLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            ])
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // Private

        private let textColor = UIColor.white
        private let secondaryTextColor = UIColor(rgb: 0x7C878E)

        private lazy var backdropImageView_: UIImageView = {
            let frame = backdropContainerView.frame
            let imageView = UIImageView(frame: frame)
            imageView.contentMode = .scaleAspectFill
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return imageView
        }()

        private lazy var backdropContainerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .black
            return view
        }()

        public lazy var shadowView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.heightAnchor.constraint(equalToConstant: 35).isActive = true
            return view
        }()

        private lazy var posterImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 2/3).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 92).isActive = true
            imageView.layer.cornerRadius = 6
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor(white: 0.7, alpha: 0.7).cgColor
            imageView.clipsToBounds = true
            return imageView
        }()

        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            let font = UIFont.preferredFont(forTextStyle: .title1)
            label.font = UIFont.boldSystemFont(ofSize: font.pointSize)
            label.textColor = textColor
            return label
        }()

        private lazy var yearLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
            label.textColor = secondaryTextColor
            return label
        }()

        private lazy var directedByLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = " ▪︎ Directed By".uppercased()
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
            label.textColor = secondaryTextColor
            return label
        }()

        private lazy var directorLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            let font = UIFont.preferredFont(forTextStyle: .subheadline)
            label.font = UIFont.boldSystemFont(ofSize: font.pointSize)
            label.textColor = textColor
            return label
        }()

        private lazy var runningTimeLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            label.textColor = secondaryTextColor
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
            label.backgroundColor = secondaryTextColor
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
            label.textColor = secondaryTextColor
            return label
        }()

        public func resize(with offset: CGFloat) {
            let initialScale: CGFloat = 1.2
            let contentHeight = contentView.frame.size.height
            if (contentHeight + offset) / contentHeight >= initialScale {
                return
            }
            let resize = (-offset / contentHeight) + initialScale
            let scale = CGAffineTransform(scaleX: resize, y: resize)
            let translation = CGAffineTransform(translationX: 0, y: offset/2)
            let result = scale.concatenating(translation)
            backdropImageView_.transform = result
        }
    }
}
