import UIKit

public extension UIView {

    func constrainEqual(attribute: NSLayoutAttribute, to: AnyObject, _ toAttribute: NSLayoutAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        NSLayoutConstraint.activate([NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: to, attribute: toAttribute, multiplier: multiplier, constant: constant)
            ])
    }
    func constrainEqual<A>(anchor: NSLayoutAnchor<A>, to other: NSLayoutAnchor<A>) {
        anchor.constraint(equalTo: other).isActive = true
    }

    func constrainEdges(to layoutGuide: UILayoutGuide, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: insets.bottom).isActive = true
        leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: insets.right).isActive = true
    }

    func constrainEdges(to view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        constrainEqual(attribute: .top, to: view, .top, multiplier: 1, constant: -insets.top)
        constrainEqual(attribute: .leading, to: view, .leading, multiplier: 1, constant: -insets.left)
        constrainEqual(attribute: .trailing, to: view, .trailing, multiplier: 1, constant: insets.right)
        constrainEqual(attribute: .bottom, to: view, .bottom, multiplier: 1, constant: insets.bottom)
    }

    func center(in view: UIView? = nil) {
        guard let container = view ?? self.superview else { fatalError() }
        centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0).isActive = true
        centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 0).isActive = true
    }
}


