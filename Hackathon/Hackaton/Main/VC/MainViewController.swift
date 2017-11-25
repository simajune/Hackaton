
import UIKit
import Firebase
import CountdownLabel
// MARK: 메인 부분

let formatter = DateFormatter()
let userCash = "cash"
let userTotalTime = "totalTime"


class MainViewController: UIViewController {
    
    @IBOutlet weak var btnStackView: UIStackView!
    
    @IBOutlet weak var startBtn: UIButton!
    
    @IBOutlet weak var cashLB: UILabel!
    @IBOutlet weak var countDownLB: CountdownLabel!
    
    // MARK: 프로퍼티
    
    var seconds = 0
    var cash = 0
    var totalTime = 0
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
                timerRunning(TimeInterval(seconds))
                startBtn.isHidden = true
            }
        }
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        ref.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                self.cash = value[userCash] as! Int
                self.totalTime = value[userTotalTime] as! Int
                self.cashLB.text = "\(self.cash)"
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: 메소드
    // 분을 초로 계산하는 메소드
    func minutesToSeconds(minutes minuteValue: Int) -> Int
    {
       return minuteValue
    }
    
   // countDown
    func timerRunning(_ seconds: TimeInterval)
    {
        countDownLB.setCountDownTime(minutes: seconds)
        countDownLB.countdownDelegate = self
        countDownLB.start()
    }
    
    @IBAction func detailButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
    @IBAction func settingsButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }
    
}

extension MainViewController: CountdownLabelDelegate {
    // MARK: countdownFinished()
    // 타이머가 끝나고 난 후
    func countdownFinished()
    {
        //오늘 날짜 저장
        formatter.dateFormat = "yyyyMMdd"
        let date = Date()
        let todayDate = formatter.string(from: date)
        
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
        
        ref.child(uid).updateChildValues([userCash : cash])
        ref.child(uid).updateChildValues([userTotalTime : totalTime])
        
        let alertController = Alert.showAlertController(title: "CASH", message: "\(cash)", actionStyle: UIAlertActionStyle.default, cancelButton: false, complition: nil)
        present(alertController, animated: true, completion: nil)
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
