import UIKit
import SafariServices

final class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var didTapLogIn: () -> () = {}

    @IBAction func authenticationAction(_ sender: UIButton) {
        didTapLogIn()
    }
}


