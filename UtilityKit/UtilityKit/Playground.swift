import UIKit

public enum Device {
    case phone4inch
    case phone4_7inch
    case phone5_5inch
    case pad
}

public enum Orientation {
    case portrait
    case landscape
}

extension UIViewController {

    public convenience init(
        child: UIViewController,
        device: Device = .phone4_7inch,
        orientation: Orientation = .portrait,
        contentSizeCategory: UIContentSizeCategory = .large,
        additionalTraits: UITraitCollection = .init())
    {
        self.init(nibName: nil, bundle: nil)
        addChildViewController(child)

        let traits: UITraitCollection
        let parentSize: CGSize
        switch (device, orientation) {
        case (.phone4inch, .portrait):
            parentSize = .init(width: 320, height: 575)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4inch, .landscape):
            parentSize = .init(width: 575, height: 320)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4_7inch, .portrait):
            parentSize = .init(width: 375, height: 667)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4_7inch, .landscape):
            parentSize = .init(width: 667, height: 375)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone5_5inch, .portrait):
            parentSize = .init(width: 414, height: 736)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone5_5inch, .landscape):
            parentSize = .init(width: 736, height: 414)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.pad, .portrait):
            parentSize = .init(width: 768, height: 1024)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .pad)
                ])
        case (.pad, .landscape):
            parentSize = .init(width: 1024, height: 768)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .pad)
                ])
        }

        let allTraits = UITraitCollection(traitsFrom: [
            traits,
            additionalTraits,
            .init(preferredContentSizeCategory: contentSizeCategory)
            ])
        setOverrideTraitCollection(allTraits, forChildViewController: child)

        view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false

        view.frame.size = parentSize
        preferredContentSize = parentSize
        view.backgroundColor = .white
        child.view.backgroundColor = .white

        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }

}
