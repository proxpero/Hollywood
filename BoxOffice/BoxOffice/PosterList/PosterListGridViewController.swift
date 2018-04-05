import UIKit
import TMDbAPI
import Promises
import UtilityKit

public final class PostListGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public var posters: [PosterCell.Item] = []

    public var load: (TMDb.Movie.ListType, Page, @escaping ([PosterCell.Item]) -> ()) -> () = { _,_,_ in }
    public var didSeletPosterItem: (PosterCell.Item) -> () = { _ in }

    private let listType: TMDb.Movie.ListType
    private var page: Page = 1

    private let networkEngine: NetworkEngine

    public init(listType: TMDb.Movie.ListType, networkEngine: NetworkEngine) {
        self.listType = listType
        self.networkEngine = networkEngine
        super.init(nibName: nil, bundle: nil)
    }

    public override func loadView() {

        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(rgb: 0x1c212b)
        collectionView.contentInset = UIEdgeInsets.init(top: -25, left: 15, bottom: 15, right: 15)
        collectionView.register(PosterCell.self)

        view = collectionView
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poster = posters[indexPath.row]
        didSeletPosterItem(poster)
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == posters.count - 20 {
            loadNextPage()
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posters.count
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.bounds.width - (2 * 15)) / 4) - 4
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == posters.count - 20 {
            loadNextPage()
        }

        let cell = collectionView.dequeue(PosterCell.self, for: indexPath)
        let item = posters[indexPath.row]
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

    public func loadNextPage() {
        self.load(listType, page, appendResults)
        page += 1
    }

    public func appendResults(_ result: [PosterCell.Item]) {
        if let collectionView = view as? UICollectionView {
            if posters.isEmpty {
                posters.append(contentsOf: result)
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
                return
            }

            DispatchQueue.main.async {
                collectionView.performBatchUpdates({
                    let startRow = self.posters.count
                    let endRow = startRow + result.count
                    let indexPaths = (startRow ..< endRow).map { IndexPath.init(row: $0, section: 0) }
                    self.posters.append(contentsOf: result)
                    collectionView.insertItems(at: indexPaths)
                }, completion: { _ in })
            }
        }
    }

}
