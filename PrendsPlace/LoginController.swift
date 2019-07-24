import UIKit

class LoginController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var responseLabel: UILabel!
    
    @IBAction func connection(_ sender: Any) {
        let url = URL(string: "http://192.168.1.21:8080/login")
        
        if let url = url {
            var request = URLRequest.init(url: url as URL)
            request.httpMethod = "POST"
            
            let body = "username=" + loginField.text! + "&password=" + passwordField.text!

            request.httpBody = body.data(using: .utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                let response = response as? HTTPURLResponse
                
                if let response = response {
                    if response.statusCode == 200 {
                        DispatchQueue.main.sync {
                            self.performSegue(withIdentifier: "loginToMain", sender: self)
                            
                            Global.saveSession(username: self.loginField.text!, password: self.passwordField.text!)
                        }
                    } else {
                        DispatchQueue.main.sync {
                            self.responseLabel.isHidden = false
                        }
                    }
                }
            })
            
            task.resume()
        }
    }
}
