import UIKit

extension MovieDetails {
    public final class BackdropCell: UICollectionViewCell {
        
        let initialScale: CGFloat = 1.2

        public override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(headerImage)
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public lazy var headerImage: UIImageView = {
            let frame = contentView.frame
            let imageView = UIImageView(frame: frame)
            imageView.transform = CGAffineTransform(scaleX: initialScale, y: initialScale)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            return imageView
        }()

        public lazy var gradientView: UIView = {
            let view = UIView()
            return view
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
            headerImage.transform = result
        }

    }
}
