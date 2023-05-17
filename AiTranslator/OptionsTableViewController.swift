import UIKit

// Define a protocol for the delegate
protocol OptionSelectionDelegate: AnyObject {
    func didSelectOption(option: String, code:String, buttonId: Int)
}

class OptionsTableViewController: UITableViewController {
    
    // Define the options array
    let options = ["English", "Turkish", "Spanish", "German", "Italian"]
    let codes = ["EN", "TR", "ES", "DE", "IT"]
    var buttonNumber: Int?
    
    // Create a weak reference to the delegate
    weak var delegate: OptionSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        let selectedCode = codes[indexPath.row]
        
        // Call the delegate method
        delegate?.didSelectOption(option: selectedOption, code: selectedCode, buttonId: buttonNumber!)
        
        // Navigate back
        navigationController?.popViewController(animated: true)
    }
}
