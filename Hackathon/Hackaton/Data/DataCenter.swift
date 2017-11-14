
import Foundation

class DataCenter {
    static var standard = DataCenter()
    
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
    var totalTime: Int?
}
