import UIKit

class InterestsController: UIViewController,UITableViewDataSource {
    var rows: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        
        let text = rows[indexPath.row]
        
        cell.textLabel?.text = text
        
        return cell
    }
    
    @IBOutlet weak var interestsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://192.168.1.21:8080/interests")
        
        if let url = url {
            var request = URLRequest.init(url: url as URL)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data!, options : .allowFragments) as? [Dictionary<String,Any>] {
                        for o in jsonArray {
                            var title = o["name"]
                            //print(type(of: title))
                            
                            if let title = title {
                                
                                //print(title)
                                self.rows.append(String(describing: title))
                            }
                        }
                    }
                } catch let err as NSError {
                    print(err)
                }
            })
            
            task.resume()
        }
        
        interestsTable.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
