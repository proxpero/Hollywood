import UIKit

public extension Date {

    static var now: Date { return Date() }

    func isEarlier(than proposedFutureDate: Date) -> Bool {
        return self < proposedFutureDate
    }

    func isLater(than proposedEarlierDate: Date) -> Bool {
        return self > proposedEarlierDate
    }

    private static let dateFormatter: DateFormatter = {
        return DateFormatter()
    }()

    init?(string: String, dateFormat: String) {
        Date.dateFormatter.dateFormat = dateFormat
        guard let date = Date.dateFormatter.date(from: string) else { return nil }
        self = date
    }
}
