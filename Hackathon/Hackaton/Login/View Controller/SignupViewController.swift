
import UIKit
import Firebase



class SignupViewController: UIViewController {
    
    //MARK: - Property
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //키보드에 대한 Notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(noti:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(noti:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - Notification Cneter
    @objc func keyboardWillShow(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
    }
    
    @objc func keyboardWillHide(noti: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    //MARK: - Method
    @IBAction func dismissButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signupButtonAction(_ sender: CustomButton) {
        guard let password = passwordTextField.text else { return }
        guard let repassword = rePasswordTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        if password != repassword {
            wrongSignup()
            
        }else {
            //비밀번호가 일치할 때
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                //에러가 없고 유저 내용이 있는 경우
                if error == nil && user != nil {
                    print("User Created")
                    UserDefaults.standard.set(email, forKey: "username")
                    
                    let userDic: [String: Any] = ["user": email, "cash": 0, "totalTime": 0]
                    self.ref.child(user!.uid).setValue(userDic)
                    
                    let alertSheet = UIAlertController(title: "가입 완료", message: "가입이 성공적으로\n이루어졌습니다", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                        let mainstoryBoard = UIStoryboard(name: "Main", bundle: nil)
                        if let mainVC = mainstoryBoard.instantiateViewController(withIdentifier: "Main") as? UINavigationController {
                            self.present(mainVC, animated: true, completion: nil)
                        }
                    })
                    alertSheet.addAction(okAction)
                    self.present(alertSheet, animated: true, completion: nil)
                //파이어 베이스상 가입시 에러가 발생했을 때
                }else {
                    let firebaseErrorMsg = error!.localizedDescription
                    let errorMsg = firebaseError(rawValue: firebaseErrorMsg)?.ErrorStr
                    let alertSheet = UIAlertController(title: "경고", message: errorMsg, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alertSheet.addAction(okAction)
                    self.present(alertSheet, animated: true, completion: nil)
                }
            })
        }
    }
    //비밀번호 동일하지 않을 때
    func wrongSignup() {
        let alertSheet = UIAlertController(title: "비밀번호 오류", message: "비밀번호가 동일하지 않습니다.", preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertSheet.addAction(OkAction)
        present(alertSheet, animated: true, completion: nil)
    }
}
    
//MARK: - Enum
//파이어베이스 가입시 발생하는 에러에 대한 한국어 처리
enum firebaseError : String{
    case alreadyEmail = "The email address is already in use by another account."
    case badlyFormatEmail = "The email address is badly formatted."
    case passwordError = "The password must be 6 characters long or more."
    
    var ErrorStr: String {
        switch self {
        case .alreadyEmail:
            return "이미 존재하는 메일입니다."
        case .badlyFormatEmail:
            return "잘못된 이메일 형식입니다."
        case .passwordError:
            return "비밀번호가 너무 짧습니다."
        }
    }
}
