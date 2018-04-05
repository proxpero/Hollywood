import UIKit

extension UIStoryboard {

    /// Returns the storyboard named "Main" in the main bundle.
    public static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    /// Instantiates a `UIViewController` that has a storyboard identifier
    /// that is identical to the name of the class.
    /// **Crashes if no storyboard can be found.**
    ///
    /// - Parameter type: A type that inherits from `UIViewController`.
    /// - Returns: An instantiated view controller of type `A`.
    public func instantiate<A: UIViewController>(_ type: A.Type) -> A {
        guard let vc = self.instantiateViewController(withIdentifier: String(describing: type.self)) as? A else {
            fatalError("Could not instantiate view controller \(A.self)") }
        return vc
    }

    /// Instantiates a `UINavigationController` that has a storyboard identifier
    /// that is identical to the name of the class.
    /// **Crashes if no storyboard can be found.**
    ///
    /// - Parameter type: A type that inherits from `UINavigationController`.
    /// - Returns: An instantiated navigation controller of type `A`.
    public func instantiateNavigationController(withIdentifier identifier: String) -> UINavigationController {
        guard let nav = instantiateViewController(withIdentifier: identifier) as? UINavigationController else { fatalError("Could not create a navigation controller with identifier \(identifier).") }
        return nav
    }

    /// Instantiates a `UIViewController` of type `A`. The method will look
    /// in the bundle where the `A` subclass is defined. The method expects a
    /// UIStoryboard in that bundle as well whose filename and identifier are
    /// both identical to `A.self`.
    /// **Crashes if no storyboard can be found**
    ///
    /// - Parameter type: A type that inherits from `UIViewController`.
    /// - Returns: An instantiated view controller of type `A`
    public static func instantiate<A: UIViewController>(_ type: A.Type) -> A {
        let bundle = Bundle(for: A.self)
        let name = String(describing: type.self)
        guard let vc = UIStoryboard
            .init(
                name: name,
                bundle: bundle
            )
            .instantiateInitialViewController() as? A else {
                fatalError("Could not instantiate a storyboard with name: \(name) in bundle \(bundle) of type \(A.self)")
        }
        return vc
    }
}

extension UIViewController {

    public static func instantiate() -> Self {
        return UIStoryboard.instantiate(self.self)
    }

}


