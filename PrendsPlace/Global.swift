import UIKit

struct Global {
    static var username = ""
    static var password = ""
    static var userId: Int = -1
    
    //static var interests: [String] = []
    
    static func saveSession(username: String, password: String) -> Void {
        Global.username = username
        Global.password = password
        
        Global.setUserId(username: username)
    }
    
    static func setUserId(username: String) -> Void {
        let url = URL(string: "http://10.33.255.41:8080/users")
    
        if let url = url {
            var request = URLRequest.init(url: url as URL)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                do {
                    if let users = try JSONSerialization.jsonObject(with: data!, options : .allowFragments) as? [Dictionary<String,Any>] {
                        for user in users {
                            if user["username"] as? String == username {
                                Global.userId = user["id"] as! Int
                            }
                        }
                    }
                } catch let err as NSError {
                    print(err)
                }
            })
            
            task.resume()
        }
    }
    
    static func disconnect() -> Void {
        Global.username = ""
        Global.password = ""
        Global.userId = -1
    }
    
    //static func getInterests()
}
