
import Foundation

class DataCenter {
    static var standard = DataCenter()
    
    var userList:[UserData] = []
    
    private init() {
        loadData()
    }
    
    func loadData(){
        guard let users = UserDefaults.standard.object(forKey: "userList") as? [[String: Any]] else { return }
        for users in users {
            if let userItem = UserData(dataDic: users) {
                userList.append(userItem)
            }
        }
            
    }
}


struct UserData {
    var username: String
    var cash: Int
    var totalTime: Int

    init?(dataDic: [String: Any]) {
        guard let username = dataDic["username"] as? String else { return nil }
        self.username = username
        guard let cash = dataDic["cash"] as? Int else { return nil }
        self.cash = cash
        guard let totalTime = dataDic["totalTime"] as? Int else { return nil }
        self.totalTime = totalTime
        
    }
}
