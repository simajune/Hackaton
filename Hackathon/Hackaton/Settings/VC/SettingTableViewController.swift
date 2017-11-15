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
        let alertController = Alert.showAlertController(title: "로그아웃", message: "정말 로그아웃하시겠습니까?", actionStyle: .destructive, cancelButton: true) { _ in
            try! Auth.auth().signOut()
            self.performSegue(withIdentifier: "Login", sender: nil)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userIdLB.text = UserDefaults.standard.string(forKey: userIdForKey)
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        versionLB.text = version ?? "읽을 수가 없습니다."
    }
}


