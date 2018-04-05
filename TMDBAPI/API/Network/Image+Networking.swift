import UIKit
import Promises

final class ImageCache {

    let queue = DispatchQueue(label: "com.proxpero.Hollywood.imageQueue")

    

}

extension Image {

    public func promise(size: A, networkEngine: NetworkEngine = URLSession.shared) -> Promise<UIImage> {
        let url = self.url(size: size)
        let resource = Resource<UIImage>(url: url, parse: UIImage.init)
        return networkEngine.load(resource)
    }

}
