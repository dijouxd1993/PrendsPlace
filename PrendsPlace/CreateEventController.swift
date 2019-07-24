import UIKit

class CreateEventController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    
    @IBAction func createEvent(_ sender: Any) {
        let url = URL(string: "http://192.168.1.21:8080/events")
        
        if let url = url {
            var request = URLRequest.init(url: url as URL)
            request.httpMethod = "POST"
            
            let param = [
                "name": nameField.text!,
                "date": dateField.text!,
                "location": locationField.text!,
                "userId": String(describing: Global.userId)
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                let response = response as? HTTPURLResponse
                
                if let response = response {
                    if response.statusCode == 201 {
                        DispatchQueue.main.sync {
                            self.performSegue(withIdentifier: "createEventToEvents", sender: self)
                        }
                    }
                }
            })
            
            task.resume()
        }
    }
}
