
import UIKit
import Firebase
import RevealingSplashView

class SplashViewController: UIViewController {

    @IBOutlet var BG: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("splash")
        logoImage.alpha = 0
        
        UIView.animate(withDuration: 2.0, animations: {
            self.logoImage.alpha = 1.0
        }) { (action) in
            if let _ = Auth.auth().currentUser {
                let mainSB = UIStoryboard(name: "Main", bundle: nil)
                if let mainVC = mainSB.instantiateViewController(withIdentifier: "Main") as? UINavigationController {
                    self.present(mainVC, animated: true, completion: nil)
                }
            }else {
                let loginSB = UIStoryboard(name: "Login", bundle: nil)
                if let loginVC = loginSB.instantiateViewController(withIdentifier: "Login") as? UINavigationController {
                    self.present(loginVC, animated: true, completion: nil)
                }
            }
            
        }

    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let LoginSB = UIStoryboard(name: "Login", bundle: nil)
//        if let LoginVC = LoginSB.instantiateViewController(withIdentifier: "Login") as? UINavigationController {
//            self.present(LoginVC, animated: true, completion: nil)
//        }

    }
}
