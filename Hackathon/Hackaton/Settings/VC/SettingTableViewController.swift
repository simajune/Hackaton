//
//  SettingTableViewController.swift
//  Hackaton

import UIKit
import Firebase

// MARK: Setting
class SettingTableViewController: UITableViewController {

    // MARK: 프로퍼티
    let userIdForKey = "username"
  
    @IBOutlet weak var userIdLB: UILabel!
    @IBOutlet weak var versionLB: UILabel!
    
    // 로그아웃 버튼
    @IBAction func logOutButton(_ sender: Any)
    {
        // 알림창
        let alert = UIAlertController(title: "로그아웃", message: "정말 로그아웃하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "예", style: .destructive, handler: { _ in
            // 이곳을 누르면 동작 하는 코드
            try! Auth.auth().signOut()
            // Login화면으로 돌아감
            //self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "Login", sender: nil)
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userIdLB.text = UserDefaults.standard.string(forKey: userIdForKey)
        guard let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else { return }
        versionLB.text = version
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


