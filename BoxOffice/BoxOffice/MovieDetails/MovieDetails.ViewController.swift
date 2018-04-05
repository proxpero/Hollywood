import UIKit
import TMDbAPI
import Promises
import UtilityKit

private let travelDistance: CGFloat = 70
private let transitionDistance: CGFloat = 90

extension MovieDetails {
    public final class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        private let movieId: Id
        private let movie: TMDb.Movie
        private let networkEngine: NetworkEngine

//        private let dataSource: MovieDetails.DataSource

        public init(movieId: Id, movie: TMDb.Movie, networkEngine: NetworkEngine) {
            self.movieId = movieId
            self.movie = movie
            self.networkEngine = networkEngine
            super.init(nibName: nil, bundle: nil)

            let details = networkEngine.load(movie.details(for: movieId))
            let credits = networkEngine.load(movie.credits(for: movieId))

            all(details, credits).then { details, credits in
                let main = Main(details: details, credits: credits)
                let credits = Credits()
                let dummy = Dummy()
                self.sections = [main, credits, dummy]
            }
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public override func loadView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 1

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(MainCell.self)
            collectionView.register(CreditsHeaderView.self, kind: .header)
            collectionView.register(RegularCell.self)

            self.view = collectionView
        }

        public override func viewWillAppear(_ animated: Bool) {
            navigationBarWillAppear()
        }

        public override func viewWillDisappear(_ animated: Bool) {
            navigationBarWillDisappear()
        }

        // Collection View Delegates and DataSource

        private var sections: [SectionType] = [] {
            didSet {
                DispatchQueue.main.async {
                    if let collectionView = self.view as? UICollectionView {
                        collectionView.reloadData()
                    }
                }
            }
        }

        public func numberOfSections(in collectionView: UICollectionView) -> Int {
            return sections.count
        }

        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let section = sections[section]
            return section.rowCount
        }

        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            switch (indexPath.section, indexPath.row) {
            case (0, 0):
                guard let viewModel = sections[0] as? Main else { fatalError() }
                let cell = collectionView.dequeue(MovieDetails.MainCell.self, for: indexPath)
                cell.setTitle(viewModel.title)
                cell.setDirector(viewModel.director)
                cell.setYear(viewModel.year)
                cell.setOverview(viewModel.overview)
                cell.setRunningTime(viewModel.runtime)

                if let poster = viewModel.poster {
                    networkEngine.load(poster).then { image in
                        cell.setPosterImage(image)
                    }
                }

                if let backdrop = viewModel.backdrop {
                    networkEngine.load(backdrop).then { image in
                        cell.setBackdropImage(image)
                    }
                }
                return cell
//            case (1, 0):
//
            default:
                let cell = collectionView.dequeue(RegularCell.self, for: indexPath)
                return cell
            }

        }

        public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let width = collectionView.bounds.width
            if indexPath.section == 0, indexPath.row == 0 {
                let headerHeight: CGFloat = width * 0.5625
                let infoHeight: CGFloat = 153
                return CGSize(width: width, height: headerHeight + infoHeight)
            }

            let height: CGFloat = 100
            let size = CGSize(width: width, height: height)
            return size
        }

        public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let section = sections[indexPath.section]
            return section.headerView
        }

        func didSelect(type: MovieDetails.CreditsHeaderView.CreditType) {
            print(type.title)
        }

        // Animations

        private func navigationBarWillAppear() {
            let bar = navigationController?.navigationBar
            bar?.shadowImage = UIImage()
            bar?.tintColor = .white
            bar?.titleTextAttributes = [.foregroundColor: UIColor.clear]
            bar?.setBackgroundImage(UIImage.pixel(with: .clear), for: .default)
        }

        private func navigationBarWillDisappear() {
            let bar = navigationController?.navigationBar
            bar?.shadowImage = nil
            bar?.tintColor = nil
            bar?.titleTextAttributes = nil
            bar?.setBackgroundImage(nil, for: .default)
        }

        let backgroundColor = UIColor(rgb: 0x171B20)

        private func animateBar(with scrollView: UIScrollView) {

            let offset = scrollView.contentOffset.y
            let topInset = scrollView.contentInset.top
            let shouldBeginTransition = (offset > 0) && (offset > travelDistance - topInset)

            func updateBarAlpha(_ alpha: CGFloat) {
                if let bar = navigationController?.navigationBar {
                    let color = backgroundColor.withAlphaComponent(alpha)
                    let pixel = UIImage.pixel(with: color.withAlphaComponent(alpha))
                    bar.setBackgroundImage(pixel, for: .default)
                }
            }

            func updateBarTitleAlpha(_ alpha: CGFloat) {
                if let bar = navigationController?.navigationBar {
                    let newColor = UIColor(white: 1, alpha: alpha)
                    bar.titleTextAttributes = [.foregroundColor: newColor]
                }
            }

            let newAlpha: CGFloat = {
                let value = (travelDistance + transitionDistance - offset - topInset)
                let result = 1 - (value / 64)
                return min(1, result)
            }()

            if shouldBeginTransition {
                updateBarAlpha(newAlpha)
                updateBarTitleAlpha(newAlpha)
                scrollView.contentInsetAdjustmentBehavior = .automatic
            } else {
                updateBarAlpha(0)
                updateBarTitleAlpha(0)
                scrollView.contentInsetAdjustmentBehavior = .never
            }
        }

        private func animateBackdropCell(with scrollView: UIScrollView) {
            if
                let collectionView = view as? UICollectionView,
                let cell = collectionView.cellForItem(at: IndexPath.zero) as? MovieDetails.MainCell
            {
                cell.resize(with: scrollView.contentOffset.y)
            }
        }

        private func animateMainCellTitle(with scrollView: UIScrollView) {
            if
                let collectionView = view as? UICollectionView,
                let cell = collectionView.cellForItem(at: IndexPath.zero) as? MainCell
            {
                let offset = scrollView.contentOffset.y
                let topInset = scrollView.contentInset.top
                let newAlpha = alphaForScrollOffset(offset: offset, topInset: topInset)
                cell.setTitleAlpha(newAlpha: 1 - newAlpha)
            }
        }

        private func alphaForScrollOffset(offset: CGFloat, topInset: CGFloat) -> CGFloat {
            let value = (travelDistance + transitionDistance - offset - topInset)
            let result = 1 - (value / 64)
            return min(1, result)
        }

        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            animateBar(with: scrollView)
            animateBackdropCell(with: scrollView)
            animateMainCellTitle(with: scrollView)
        }
    }
}

public final class RegularCell: UICollectionViewCell {}
public final class CreditCell: UICollectionViewCell {}
