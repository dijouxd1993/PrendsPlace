import UIKit

class SignInController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signIn(_ sender: Any) {
        let url = URL(string: "http://10.33.255.41:8080/users")
        
        if let url = url {
            var request = URLRequest.init(url: url as URL)
            request.httpMethod = "POST"
            
            let param = [
                "username": loginField.text!,
                "password": passwordField.text!
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                let response = response as? HTTPURLResponse
                
                if let response = response {
                    if response.statusCode == 201 {
                        DispatchQueue.main.sync {
                            self.performSegue(withIdentifier: "signInToMain", sender: self)
                        }
                    }
                }
            })
            
            task.resume()
        }
    }
}
