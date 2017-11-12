
import UIKit
import Firebase
import CountdownLabel
// MARK: 메인 부분
class MainViewController: UIViewController {
    
    @IBOutlet weak var btnStackView: UIStackView!
    
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var cashLB: UILabel!
    
    // MARK: 프로퍼티
    var seconds  = 0
    var tag = 0
    var cash = 0
    var totalTime = 0
    let userCash = "cash"
    let userTotalTime = "TotalTime"
    let timeOnTheFirstButton = 30
    let timeOnTheSecondButton = 60
    let timeOnTheThirdButton = 90
    let timeOnTheFourthButton = 120
    var userButtonTag: Int?
    
    // 버튼 액션
    @IBAction func buttonAction(_ sender: UIButton) {
        guard let buttonTag = ButtonTag(rawValue: sender.tag) else { return }
        switch buttonTag {
        case .firstButton:
            seconds = minutesToSeconds(minutes: 1)
            userButtonTag = 1
        case .secondButton:
            seconds = minutesToSeconds(minutes: timeOnTheSecondButton)
            userButtonTag = 2
        case .thirdButton:
            seconds = minutesToSeconds(minutes: timeOnTheThirdButton)
            userButtonTag = 3
        case .fourthButton:
            seconds = minutesToSeconds(minutes: timeOnTheFourthButton)
            userButtonTag = 4
        case .startButton:
            if startBtn.isHidden == false{
                countdownLabelFrame(TimeInterval(seconds))
                startBtn.isHidden = true
            }
        }
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.integer(forKey: userCash)
        UserDefaults.standard.integer(forKey: userTotalTime)
        cashLB.text = "\(cash)"
    }
    
    // MARK: 메소드
    // 분을 초로 계산하는 메소드
    func minutesToSeconds(minutes minuteValue: Int) -> Int
    {
       return minuteValue * 60
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
    // MARK: countdownFinished()
    // 타이머가 끝나고 난 후
    func countdownFinished()
    {
        guard let tag = userButtonTag else { return }
        switch tag  {
        case 1:
            cash += 100
            totalTime += timeOnTheFirstButton
        case 2:
            cash += 300
            totalTime += timeOnTheSecondButton
        case 3:
            cash += 700
            totalTime += timeOnTheThirdButton
        case 4:
            cash += 1000
            totalTime += timeOnTheFourthButton
        default:
            break
        }
        
        cashLB.text = "\(cash)"
        UserDefaults.standard.set(cash, forKey: userCash)
        UserDefaults.standard.set(totalTime, forKey: userTotalTime)
        
        let alert = UIAlertController(title: "CASH", message: "\(cash)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        startBtn.isHidden = false // 메소드가 끝나면 버튼 보이기
    }
}

// MARK: ENUM
enum ButtonTag: Int
{
    case firstButton = 1
    case secondButton = 2
    case thirdButton = 3
    case fourthButton = 4
    case startButton = 0
}
