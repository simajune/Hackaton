
import Foundation
import Firebase

let ref: DatabaseReference

struct DataCenter {
    
    var userList:[UserData] = []
    
    private init() {
        loadData()
    }
    
    func loadData(){
        
    }
}


struct UserData {
    var username: String?
    var cash: Int?
    var times: [Time] = []
    
    init?(with userDic: [String: Any]) {
        guard let username = userDic["username"] as? String else { return nil }
        self.username = username
        guard let cash = userDic["cash"] as? Int else { return nil }
        self.cash = cash
        guard let times = userDic["times"] as? [[String: Any]] else { return nil }
        for time in times {
            self.times.append(Time(with: time)!)
        }
    }
}

struct Time {
    var totalTime: String
    var monthTimes: [MonthTime] = []
    
    init?(with timeDic: [String: Any]) {
        guard let totalTime = timeDic["totalTime"] as? String else { return nil }
        self.totalTime = totalTime
        guard let monthTimes = timeDic["monthTimes"] as? [[String: Any]] else { return nil }
        for monthTime in monthTimes {
            self.monthTimes.append(MonthTime(with: monthTime)!)
        }
    }
}


struct MonthTime {
    var january: Int
    var february: Int
    var march: Int
    var april: Int
    var may: Int
    var june: Int
    var july: Int
    var august: Int
    var september: Int
    var october: Int
    var november: Int
    var december: Int
    
    init?(with monthDic: [String: Any]){
        guard let january = monthDic["january"] as? Int else { return nil }
        self.january = january
        guard let february = monthDic["february"] as? Int else { return nil }
        self.february = february
        guard let march = monthDic["march"] as? Int else { return nil }
        self.march = march
        guard let april = monthDic["april"] as? Int else { return nil }
        self.april = april
        guard let may = monthDic["may"] as? Int else { return nil }
        self.may = may
        guard let june = monthDic["june"] as? Int else { return nil }
        self.june = june
        guard let july = monthDic["july"] as? Int else { return nil }
        self.july = july
        guard let august = monthDic["august"] as? Int else { return nil }
        self.august = august
        guard let september = monthDic["september"] as? Int else { return nil }
        self.september = september
        guard let october = monthDic["october"] as? Int else { return nil }
        self.october = october
        guard let november = monthDic["november"] as? Int else { return nil }
        self.november = november
        guard let december = monthDic["december"] as? Int else { return nil }
        self.december = december
    }
}
