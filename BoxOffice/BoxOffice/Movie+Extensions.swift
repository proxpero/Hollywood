import Foundation
import TMDbAPI
import Promises

extension TMDb.Movie {

    public func detailsResultObject(for movieId: Int, appending appendOptions: AppendOptions = [], networkEngine: NetworkEngine = URLSession.shared) -> Promise<DetailResultObject> {
        let url = detailsUrl(for: movieId, appending: appendOptions)
        let resource = Resource<DetailResultObject>(url: url)
        return networkEngine.load(resource)
    }

    public func listResultObjects(for listType: ListType, page: Page, networkEngine: NetworkEngine) -> Promise<[ListResultObject]> {
        let url = self.url(listType: listType, page: page)
        let resource = Resource<TMDb.Movie.List>(url: url)
        return networkEngine.load(resource).then { list in
            return list.resultObjects
        }
    }

    public func posterListItems(for listType: ListType, page: Int = 1, networkEngine: NetworkEngine) -> Promise<PosterListCellView.ViewModel> {
        let promise = listResultObjects(for: listType, page: page, networkEngine: networkEngine)
        return promise.then { objects in
            PosterListCellView.ViewModel.init(
                title: listType.title,
                posters: objects.map(PosterCell.Item.init))
        }
    }

    public func posterCellItems(for listType: ListType, page: Page, networkEngine: NetworkEngine) -> Promise<[PosterCell.Item]> {
        return listResultObjects(for: listType, page: page, networkEngine: networkEngine).then { objects in
            return objects.map(PosterCell.Item.init)
        }
    }

    public func image(for url: URL, networkEngine: NetworkEngine = URLSession.shared) -> Promise<UIImage> {
        let resource = Resource<UIImage>(url: url, parse: UIImage.init)
        return networkEngine.load(resource)
    }

    public func url(listType: ListType, page: Page = 1) -> URL {
        let url: URL
        switch listType {
        case .popular: url = popularUrl(page: page)
        case .topRated: url = topRatedUrl(page: page)
        case .upcoming: url = upcomingUrl(page: page)
        case .nowPlaying: url = nowPlayingUrl(page: page)
        }
        return url
    }

    public enum ListType {
        case popular
        case topRated
        case upcoming
        case nowPlaying

        public var title: String {
            switch self {
            case .popular: return "Popular"
            case .topRated: return "Top Rated"
            case .upcoming: return "Upcoming"
            case .nowPlaying: return "Now Playing"
            }
        }

        var url: (TMDb.Movie, Page) -> URL {
            return { movie, page in
                switch self {
                case .popular: return movie.popularUrl(page: page)
                case .topRated: return movie.topRatedUrl(page: page)
                case .upcoming: return movie.upcomingUrl(page: page)
                case .nowPlaying: return movie.nowPlayingUrl(page: page)
                }
            }
        }
    }
}
