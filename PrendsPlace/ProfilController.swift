import UIKit

class ProfilController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func disconnect(_ sender: Any) {
        Global.disconnect()
    }
    
    @IBAction func removeAccount(_ sender: Any) {
        let url = URL(string: "http://10.33.255.41:8080/users/" + String(Global.userId))
        
        if let url = url {
            var request = URLRequest.init(url: url as URL)
            request.httpMethod = "DELETE"
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                let response = response as? HTTPURLResponse
                
                if let response = response {
                    if response.statusCode == 200 {
                        DispatchQueue.main.sync {
                            Global.disconnect()
                            self.performSegue(withIdentifier: "profilToMain", sender: self)
                        }
                    }
                }
            })
            
            task.resume()
        }
    }
}
