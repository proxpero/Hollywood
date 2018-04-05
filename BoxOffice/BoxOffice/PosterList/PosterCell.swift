import UIKit
import UtilityKit
import Promises

public final class PosterCell: UICollectionViewCell {

    public var representedUrl: URL?

    public func setTitle(_ title: String) {
        titleLabel.text = title
    }

    public func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
            self.discoverImageAnimator.startAnimation()
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(titleLabel)
        contentView.constrainEdges(to: titleLabel)
        contentView.addSubview(imageView)
        contentView.constrainEdges(to: imageView)
        
        prepareView()
    }

    private func prepareView() {
        backgroundColor = .darkGray
        layer.cornerRadius = 5
        layer.borderColor = UIColor(white: 1, alpha: 0.6).cgColor
        layer.borderWidth = 1
        clipsToBounds = true
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        representedUrl = nil
        titleLabel.text = nil
        imageView.image = nil
        imageView.alpha = 0
    }

    private var discoverImageAnimator: UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut)
        animator.addAnimations {
            self.imageView.alpha = 1
        }
        return animator
    }

}
