
import UIKit
import Firebase




class LoginViewController: UIViewController {
    
    //MARK: - Property
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    var ref: DatabaseReference!
    
    //MARK: - App Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(noti:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(noti:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - Notification Center
    @objc func keyboardWillShow(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
    }
    
    @objc func keyboardWillHide(noti: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    //MARK: - Method
    @IBAction func loginButtonAction(_ sender: CustomButton) {
        guard let id = emailTextField.text else { return }
        guard let pw = passwordTextField.text else { return }
        loadingIndicatorView.startAnimating()
        
        //파이어베이스 로그인
        Auth.auth().signIn(withEmail: id, password: pw) { (user, error) in
            self.loadingIndicatorView.stopAnimating()
            if error == nil && user != nil {
                let alertSheet = Alert.showAlertController(title: "로그인 성공", message: "로그인이 정상적으로\n 되었습니다.", cancelButton: false, complition: { (action) in
                    let mainstoryBoard = UIStoryboard(name: "Main", bundle: nil)
                    if let mainVC = mainstoryBoard.instantiateViewController(withIdentifier: "Main") as? UINavigationController {
                        self.present(mainVC, animated: true, completion: nil)
                    }
                })
                self.present(alertSheet, animated: true, completion: nil)
                
            }else {
                print(error!.localizedDescription)
                let loginErrorMsg = error!.localizedDescription
                let errorMsg = loginError(rawValue: loginErrorMsg)?.ErrorStr
                let alertSheet = Alert.showAlertController(title: "경고", message: errorMsg, cancelButton: false, complition: nil)

                self.present(alertSheet, animated: true, completion: nil)
            }
        }
    }
}


enum loginError : String{
    case noEmail = "There is no user record corresponding to this identifier. The user may have been deleted."
    case badlyFormatEmail = "The email address is badly formatted."
    case passwordError = "The password is invalid or the user does not have a password."
    
    var ErrorStr: String {
        switch self {
        case .noEmail:
            return "존재하지 않는 메일입니다."
        case .badlyFormatEmail:
            return "잘못된 이메일 형식입니다."
        case .passwordError:
            return "비밀번호가 틀렸습니다."
        }
    }
}
