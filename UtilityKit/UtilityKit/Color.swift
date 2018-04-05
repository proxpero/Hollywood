import UIKit

extension UIColor {

    public convenience init(rgb: UInt32, alpha: CGFloat = 1.0) {
        self.init(
            red:    CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green:  CGFloat((rgb & 0x00FF00) >>  8) / 255.0,
            blue:   CGFloat((rgb & 0x0000FF) >>  0) / 255.0,
            alpha:  alpha
        )
    }

    public static func random() -> UIColor {
        let hex = arc4random_uniform(UInt32.max)
        return UIColor(rgb: hex)
    }

}
