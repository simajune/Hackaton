
import UIKit
import Firebase
import CountdownLabel
// MARK: 메인 부분
class MainViewController: UIViewController {
    
    @IBOutlet weak var btnStackView: UIStackView!
    
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var cashLB: UILabel!
    
    // MARK: 프로퍼티
    var temp = 0
    var tag = 0
    var cash = 0
    var TotalTime = 0
    
    // 버튼 액션
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            temp = minutesToSeconds(1)
            self.tag = sender.tag
        case 2:
            temp = minutesToSeconds(60)
            self.tag = sender.tag
        case 3:
            temp = minutesToSeconds(90)
            self.tag = sender.tag
        case 4:
            temp = minutesToSeconds(120)
            self.tag = sender.tag
        case 5:
            countdownLabelFrame(TimeInterval(temp))
        default:
            break
        }
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        cash = UserDefaults.standard.integer(forKey: "cash")
        cashLB.text = String(cash)
        TotalTime = UserDefaults.standard.integer(forKey: "totalTime")
    }
    
    // MARK: 메소드
    // 분을 초로 계산하는 메소드
    func minutesToSeconds(_ minutes: Int) -> Int
    {
       return minutes * 60
    }
    
    // CountdownLabel 프레임
    func countdownLabelFrame(_ seconds: TimeInterval)
    {
        //카운드 다운 셋팅
        let countDownlabel = CountdownLabel(frame: CGRect(x: 0, y: btnStackView.frame.maxY, width: view.frame.width, height: startBtn.frame.minY - btnStackView.frame.maxY), minutes: seconds)
        countDownlabel.textAlignment = .center
        countDownlabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(countDownlabel)
        countDownlabel.countdownDelegate = self
        countDownlabel.start()
        
    }
    
    @IBAction func detailButtonAction(_ sender: UIButton) {
//        UserDefaults.standard.set(<#T##url: URL?##URL?#>, forKey: <#T##String#>)
        let detailSB = UIStoryboard(name: "Detail", bundle: nil)
        if let detailVC = detailSB.instantiateViewController(withIdentifier: "Detail") as? UINavigationController {
            self.present(detailVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func settingsButtonAction(_ sender: UIButton) {
        let settingsSB = UIStoryboard(name: "Settings", bundle: nil)
        if let settingsVC = settingsSB.instantiateViewController(withIdentifier: "SettingStoryboard") as? SettingTableViewController {
            self.present(settingsVC, animated: true, completion: nil)
        }
    }
    
}

extension MainViewController: CountdownLabelDelegate {
    func countdownFinished()
    {
        if tag == 1 {
            cash  += 100
            cashLB.text = String(cash)
            UserDefaults.standard.set(cash, forKey: "cash")
            TotalTime  += 30
            UserDefaults.standard.set(TotalTime, forKey: "totalTime")
        }else if tag == 2 {
            cash  += 300
            cashLB.text = String(cash)
            UserDefaults.standard.set(cash, forKey: "cash")
            TotalTime  += 60
            UserDefaults.standard.set(TotalTime, forKey: "totalTime")
        }else if tag == 3 {
            cash  += 700
            cashLB.text = String(cash)
            UserDefaults.standard.set(cash, forKey: "cash")
            TotalTime  += 90
            UserDefaults.standard.set(TotalTime, forKey: "totalTime")
        }else {
            cash  += 1000
            cashLB.text = String(cash)
            UserDefaults.standard.set(cash, forKey: "cash")
            TotalTime  += 120
            UserDefaults.standard.set(TotalTime, forKey: "totalTime")
        }
        
        
    }
}
