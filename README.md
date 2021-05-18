import UIKit

let apiKey = "99e0a3f40b9844c594e36fbb681e3c0c"
let apiHost = "https://newsapi.org/v2/"

struct ApiRespT : Codable {
    var articles : [RowT]
}

struct SourceT : Codable  {
    var id : String?
    var name : String?
}

struct RowT:Codable {
    var source: SourceT?
    var author : String?
    var title : String?
    var description : String?
    var url:String?
    var urlToImage:String?
    var publishedAt: String?
    var content:String?
}

var rows = [RowT]()
var idx = -1

class TableViewController: UITableViewController {
    @IBOutlet var tableview: UITableView!
    
    @IBAction func backBut(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialDataLoad()
    }
    
    func initialDataLoad() {
        let urlString = "\(apiHost)everything?q=\(bloom)&apiKey=\(apiKey)"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        do {
            rows = try decoder.decode(ApiRespT.self, from: json).articles
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        } catch {
            print(error)
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = rows[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        idx = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
