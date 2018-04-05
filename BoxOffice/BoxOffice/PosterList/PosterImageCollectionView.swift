import UIKit
import TMDbAPI

public final class PosterImagesCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    public var items: [PosterCell.Item] = []
    public var didSelectItem: (PosterCell.Item) -> () = { _ in }

    public init(layout: UICollectionViewLayout = PosterImagesCollectionView.defaultLayout, networkEngine: NetworkEngine = URLSession.shared) {

        self.networkEngine = networkEngine
        super.init(frame: .zero, collectionViewLayout: layout)

        backgroundColor = nil
        delegate = self
        dataSource = self
        contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        register(PosterCell.self)
    }

    private let networkEngine: NetworkEngine

    public static let defaultLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 92, height: 138)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        return layout
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelectItem(item)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let cell = collectionView.dequeue(PosterCell.self, for: indexPath)
        cell.setTitle(item.title)
        cell.representedUrl = item.imageUrl

        if let url = item.imageUrl {
            let resource = Resource<UIImage>(url: url, parse: UIImage.init)
            networkEngine.load(resource).then { image in
                guard cell.representedUrl == item.imageUrl else { return }
                cell.setImage(image)
            }
        }
        return cell
    }

}
