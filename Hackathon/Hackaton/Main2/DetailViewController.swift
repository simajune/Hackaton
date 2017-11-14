//UserDefault 저장 데이터
//1. 현재 시간
//2. 캐쉬
//3. 총 시간

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    //MARK: - Property
    @IBOutlet weak var cashLb: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var sunHeight: NSLayoutConstraint!
    @IBOutlet weak var monHeight: NSLayoutConstraint!
    @IBOutlet weak var tueHeight: NSLayoutConstraint!
    @IBOutlet weak var wedHeight: NSLayoutConstraint!
    @IBOutlet weak var thuHeight: NSLayoutConstraint!
    @IBOutlet weak var friHeight: NSLayoutConstraint!
    @IBOutlet weak var satHeight: NSLayoutConstraint!
    
    @IBOutlet weak var sunTree: UIImageView!
    @IBOutlet weak var monTree: UIImageView!
    @IBOutlet weak var tueTree: UIImageView!
    @IBOutlet weak var wedTree: UIImageView!
    @IBOutlet weak var thuTree: UIImageView!
    @IBOutlet weak var friTree: UIImageView!
    @IBOutlet weak var satTree: UIImageView!
    
    var totalMinutes: Int = 0
    var totalCash: Int = 0
    var uid: String!
    var ref: DatabaseReference!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initialTreeView()
        uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
    }
    //MARK: - 나무 알파 값 초기화
    func initialTreeView() {
        self.sunTree.alpha = 0
        self.monTree.alpha = 0
        self.tueTree.alpha = 0
        self.wedTree.alpha = 0
        self.thuTree.alpha = 0
        self.friTree.alpha = 0
        self.satTree.alpha = 0
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //데이터 값 불러오기
        //캐쉬 값 불러오기
//        totalCash = UserDefaults.standard.integer(forKey: "cash")
        ref.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.totalCash = value?["cash"] as? Int ?? 0
            self.totalMinutes = value?["totalTime"] as? Int ?? 0
        }
        //총 시간 불러오기
//        totalMinutes = UserDefaults.standard.integer(forKey: "totalTime")
        
        totalTime.text = "금주 총 집중한 시간 : " + String(totalMinutes) + "분"
        cashLb.text = String(totalCash)
    }
    
    //MARK: - ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2.5) {
            self.sunTree.alpha = 1.0
            self.wedTree.alpha = 1.0
            self.friTree.alpha = 1.0
            self.sunHeight = self.sunHeight.changeMultiplier(changeMultiplier: 0.5)
            self.monHeight = self.monHeight.changeMultiplier(changeMultiplier: 0.1)
            self.tueHeight = self.tueHeight.changeMultiplier(changeMultiplier: 0.001)
            self.wedHeight = self.wedHeight.changeMultiplier(changeMultiplier: 0.9)
            self.thuHeight = self.thuHeight.changeMultiplier(changeMultiplier: 0.4)
            self.friHeight = self.friHeight.changeMultiplier(changeMultiplier: 0.6)
            self.satHeight = self.satHeight.changeMultiplier(changeMultiplier: 0.3)
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Method
    @IBAction func homeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func settingsButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }
}

//MARK: - Extension
extension NSLayoutConstraint {
    func changeMultiplier(changeMultiplier: CGFloat) -> NSLayoutConstraint {
        NSLayoutConstraint.deactivate([self])
        let newConstaint = NSLayoutConstraint(item: self.firstItem,
                                              attribute: self.firstAttribute,
                                              relatedBy: self.relation,
                                              toItem: self.secondItem,
                                              attribute: self.secondAttribute,
                                              multiplier: changeMultiplier,
                                              constant: self.constant)
        newConstaint.priority = self.priority
        newConstaint.shouldBeArchived = self.shouldBeArchived
        newConstaint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstaint])
        
        return newConstaint
    }
}
