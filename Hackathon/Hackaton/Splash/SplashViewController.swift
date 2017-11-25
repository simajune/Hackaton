
import UIKit
import Firebase
import RevealingSplashView
import SwiftKeychainWrapper

class SplashViewController: UIViewController {
    
    @IBOutlet var BG: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    let userKey = "username"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print("splash")
        logoImage.alpha = 0
        
        //        UIView.animate(withDuration: 2.0, animations: {
        //            self.logoImage.alpha = 1.0
        //        }) { [weak self]_ in
        //            guard let `self` = self else{ return }
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
        //                if let keyData = KeychainWrapper.standard.data(forKey: self.userKey), let account = try? JSONDecoder().decode(Account.self, from: keyData){
        //                    Auth.auth().signIn(withEmail: account.email, password: account.password, completion: { (user, error) in
        //                        if error == nil, user != nil{
        //                            self.performSegue(withIdentifier: "segueSplashToMain", sender: nil)
        //                        }else{
        //                            KeychainWrapper.standard.removeObject(forKey: self.userKey)
        //                            self.performSegue(withIdentifier: "segueSplashToLogin", sender: nil)
        //                        }
        //                    })
        //                }else{
        //                    self.performSegue(withIdentifier: "segueSplashToLogin", sender: nil)
        //                }
        //
        //            })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 2.0, animations: {
                self.logoImage.alpha = 1.0
            }, completion: { [weak self] _ in
                guard let `self` = self else{ return }
                if let keyData = KeychainWrapper.standard.data(forKey: self.userKey), let account = try? JSONDecoder().decode(Account.self, from: keyData){
                    Auth.auth().signIn(withEmail: account.email, password: account.password, completion: { (user, error) in
                        if error == nil, user != nil{
                            self.performSegue(withIdentifier: "segueSplashToMain", sender: nil)
                        }else{
                            KeychainWrapper.standard.removeObject(forKey: self.userKey)
                            self.performSegue(withIdentifier: "segueSplashToLogin", sender: nil)
                        }
                    })
                }else{
                    self.performSegue(withIdentifier: "segueSplashToLogin", sender: nil)
                }
            })
        }
    }
}

struct Account: Decodable{
    var email: String
    var password: String
}


