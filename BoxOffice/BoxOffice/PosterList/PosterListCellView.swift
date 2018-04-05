import UIKit
import UtilityKit
import TMDbAPI
import Promises

public final class PosterListCellView: UICollectionViewCell {

    public struct ViewModel {
        let title: String
        let posters: [PosterCell.Item]
        public init(title: String, posters: [PosterCell.Item]) {
            self.title = title
            self.posters = posters
        }
    }

    //MARK: Public

    public var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            DispatchQueue.main.async {
                self.label.text = viewModel.title
                self.collectionView.items = viewModel.posters
                self.collectionView.reloadData()
            }
        }
    }

    public var networkEngine: NetworkEngine = URLSession.shared
    public var didSelectItem: (PosterCell.Item) -> () = { _ in }

    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                let color = UIColor.init(white: 1.0, alpha: 0.1)
                backgroundColor = color
            } else {
                backgroundColor = nil
            }
        }
    }

    //MARK: Private

    private lazy var collectionView: PosterImagesCollectionView = {
        let collectionView = PosterImagesCollectionView(networkEngine: networkEngine)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        contentView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15).isActive = true
        collectionView.didSelectItem = didSelectItem
        return collectionView
    }()

    public lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        label.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -5).isActive = true
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        label.text = "List Title"
        return label
    }()

}
