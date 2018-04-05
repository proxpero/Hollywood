import UIKit
import TMDbAPI
import Promises
import UtilityKit

public final class PosterListCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public var items: [PosterListCellView.ViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                if let collectionView = self.view as? UICollectionView {
                    collectionView.reloadData()
                }
            }
        }
    }

    public var networkEngine: NetworkEngine!
    public var didSelectPosterCellItem: (PosterCell.Item) -> () = { _ in }
    public var didSelectListAtIndex: (Int) -> () = { _ in }

    public override func loadView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PosterListCellView.self)
        self.view = collectionView
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 92*1.5 + 30 + 18)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectListAtIndex(indexPath.row)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(PosterListCellView.self, for: indexPath)
        let item = items[indexPath.row]
        cell.viewModel = item
        cell.networkEngine = networkEngine
        cell.didSelectItem = { item in
            self.didSelectPosterCellItem(item)
        }
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}
