import UIKit

extension MovieDetails {
    public final class HeaderCell: UICollectionViewCell {

        let initialScale: CGFloat = 1.2

        public func setBackdropImage(_ image: UIImage) {
            backdropImage.image = image
            backdropImage.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
        }

        public override init(frame: CGRect) {
            super.init(frame: frame)
            imageContainerView.addSubview(backdropImage)
            contentView.addSubview(imageContainerView)
            contentView.constrainEdges(to: imageContainerView)
            backdropImage.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private lazy var imageContainerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        public lazy var backdropImage: UIImageView = {
            let frame = imageContainerView.frame
            let imageView = UIImageView(frame: frame)
            imageView.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return imageView
        }()

        public func resize(with offset: CGFloat) {
            let contentHeight = contentView.frame.size.height
            if (contentHeight + offset) / contentHeight >= initialScale {
                return
            }
            let resize = (-offset / contentHeight) + initialScale
            let scale = CGAffineTransform(scaleX: resize, y: resize)
            let translation = CGAffineTransform(translationX: 0, y: offset/2)
            let result = scale.concatenating(translation)
            backdropImage.transform = result
        }

    }
}
