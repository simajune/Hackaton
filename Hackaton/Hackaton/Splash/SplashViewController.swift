
import UIKit
//import Firebase


class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("splash")
        

//        if let _ = Auth.auth().currentUser {
//
//        }else {
//
//        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let LoginSB = UIStoryboard(name: "Login", bundle: nil)
        if let LoginVC = LoginSB.instantiateViewController(withIdentifier: "Login") as? LoginViewController {
            self.present(LoginVC, animated: true, completion: nil)
        }
    }
}
