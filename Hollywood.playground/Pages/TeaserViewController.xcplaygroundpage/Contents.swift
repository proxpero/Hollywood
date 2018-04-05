import UIKit
import PlaygroundSupport
import Telephone
import TMDbAPI

final class PosterCell: UICollectionViewCell {

    var image: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.imageView.image = self.image
            }
        }
    }

    private let imageView: UIImageView

    override init(frame: CGRect) {
        self.imageView = UIImageView(frame: .zero)
        super.init(frame: frame)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.borderColor = UIColor(white: 0.60, alpha: 1.0).cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true

        contentView.addSubview(imageView)
        contentView.constrainEdges(to: imageView)
    }

    override func prepareForReuse() {
        image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


public class TeaserViewController: UIViewController {

    let listTitle: String
    public var itemList: [TMDb.Movie.ListResultObject] {
        didSet {
            if let collectionView = view as? UICollectionView {
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }
        }
    }

    public init(listTitle: String, itemList: [TMDb.Movie.ListResultObject]) {
        self.listTitle = listTitle
        self.itemList = itemList
        super.init(nibName: nil, bundle: nil)
    }

    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = listTitle
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 92, height: 92*1.5)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    public override func loadView() {
        let view = UIStackView(arrangedSubviews: [])
        self.view = view
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TeaserViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PosterCell.self, for: indexPath)
        cell.image = UIImage.randomColor(size: cell.bounds.size)
        return cell
    }
}

let vc = TeaserViewController(listTitle: "Hello", itemList: [])

let parent = playgroundWrapper(child: vc,
                               device: .phone5_5inch,
                               orientation: .portrait,
                               contentSizeCategory: .large
)
PlaygroundPage.current.liveView = parent
