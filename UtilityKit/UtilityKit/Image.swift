import UIKit

public extension UIImage {

    public static func pixel(with color: UIColor) -> UIImage {
        let pixel = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(pixel.size)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }

        context.setFillColor(color.cgColor)
        context.fill(pixel)

        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }

    public static func solid(color: UIColor, size: CGSize) -> UIImage {
        let solid = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(solid.size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.setFillColor(color.cgColor)
        context.fill(solid)

        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }

    public static func randomColor(size: CGSize) -> UIImage {
        return UIImage.solid(color: UIColor.random(), size: size)
    }

    /// Creates a `URL` from `urlString` and loads it from the network.
    public static func load(from urlString: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        loadURL(url, completion: completion)
    }

    /// Loads the image at `url` from the network.
    public static func loadURL(_ url: URL, completion: @escaping (UIImage) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                completion(image)
            }
            }.resume()
    }

    /// Resize `self` to `size`.
    /// - parameter size: A `CGSize` of the new desired size.
    /// - parameter isOpaque: If `self` has transparency, set this to `false`.
    /// - returns: A new `UIImage`.
    public func scaled(to size: CGSize, isOpaque: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, isOpaque, 0.0)
        let imageRect = CGRect(origin: .zero, size: size)
        self.draw(in: imageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }

    /// Resizes a square image to a max side length of `maxLength`.
    /// - parameter maxLength: A `CGFloat` representing the maximum side length.
    /// - returns: A resized UIImage, either with height and width equal to
    /// `maxLength` or less `self` is already smaller than `maxLength`.
    public func resizedSquare(maxLength: CGFloat) -> UIImage? {
        if self.size.height < maxLength { return self }
        let scaledSize = CGSize(width: maxLength, height: maxLength)
        guard let scaledImage = self.scaled(to: scaledSize) else {
            return nil
        }
        return scaledImage
    }

}

extension UIImageView {
    public static func randomColor(frame: CGRect) -> UIImageView {
        let result = UIImageView.init(frame: frame)
        result.image = UIImage.randomColor(size: frame.size)
        return result
    }

    public func randomColor() {
        self.image = UIImage.randomColor(size: self.bounds.size)
    }

    public func addBlackGradientLayer(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
}

public extension UIButton {

    /// Sets the background color of a button for a particular state.
    ///
    /// - Parameters:
    ///   - backgroundColor: The color to set.
    ///   - state: The state for the color to take affect.
    public func setBackgroundColor(_ backgroundColor: UIColor, forState state: UIControlState) {
        self.setBackgroundImage(.pixel(with: backgroundColor), for: state)
    }
}



