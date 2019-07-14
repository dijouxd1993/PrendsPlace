import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var responseLabel: UILabel!
    
    @IBAction func connection(_ sender: Any) {
        let url = URL(string: "http://192.168.1.21:8080/login")
        
        //var success = false
        
        if let url = url {
            var request = URLRequest.init(url: url as URL)
            request.httpMethod = "POST"
            
            var body = "username=" + loginField.text! + "&password=" + passwordField.text!

            request.httpBody = body.data(using: .utf8)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                let response = response as? HTTPURLResponse
                
                if let response = response {
                    if response.statusCode == 200 {
                        self.performSegue(withIdentifier: "loginToMain", sender: self)
                    } else {
                        self.responseLabel.isHidden = false
                    }                    
                }
            })
            
            task.resume()
        }
    }
}
