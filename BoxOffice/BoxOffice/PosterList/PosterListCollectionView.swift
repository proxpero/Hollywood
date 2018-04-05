//import UIKit
//import TMDbAPI
//import Promises
//import UtilityKit
//
//public final class PosterListCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    public func setItems(_ items: [PosterListCellView.ViewModel]) {
//        self.items = items
//    }
//
//    public func setItems(_ items: [Promise<PosterListCellView.ViewModel>]) {
//        all(items).then {
//            self.items = $0
//        }.catch { error in
//            print("FIXME! \(error)")
//            self.items = []
//        }
//    }
//
//    private var items: [PosterListCellView.ViewModel] = [] {
//        didSet {
//            DispatchQueue.main.async {
//                self.reloadData()
//            }
//        }
//    }
//    
//    public var networkEngine: NetworkEngine = URLSession.shared
//
//    public var didSelectPosterCellItem: (PosterCell.Item) -> () = { _ in }
//    public var didSelectListAtIndex: (Int) -> () = { _ in }
//
//    public static let defaultLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 3
//        layout.minimumInteritemSpacing = 3
//        return layout
//    }()
//
//    public init(layout: UICollectionViewLayout = PosterListCollectionView.defaultLayout) {
//        super.init(frame: .zero, collectionViewLayout: layout)
//        backgroundColor = nil
//        delegate = self
//        dataSource = self
//        register(PosterListCellView.self)
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.width, height: 92*1.5 + 30 + 18)
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        didSelectListAtIndex(indexPath.row)
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(items.count)
//        return items.count
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(PosterListCellView.self, for: indexPath)
//        let item = items[indexPath.row]
//        cell.viewModel = item
//        cell.networkEngine = networkEngine
//        cell.didSelectItem = didSelectPosterCellItem
//        return cell
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//}
