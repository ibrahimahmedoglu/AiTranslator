import UIKit

class ViewController: UIViewController, OptionSelectionDelegate, UITextFieldDelegate {
    func didSelectOption(option: String, code: String, buttonId: Int) {
        if(buttonId == 1){
            dropdownButton1.setTitle(option, for: .normal)
            sourceLanguage = code
            
        } else if(buttonId == 2){
            dropdownButton2.setTitle(option, for: .normal)
            targetLanguage = code

        }
    }
    

    // Define the dropdown buttons using outlets
    @IBOutlet weak var enteredTextField: UITextField!
    
    @IBOutlet weak var translatedTextField: UITextField!
    @IBOutlet weak var dropdownButton1: UIButton!
    @IBOutlet weak var dropdownButton2: UIButton!
    let apiKey = "9507af22-34d4-1e74-0e1d-0a80381fa19b:fx"
    var targetLanguage = "TR"
    var sourceLanguage = "EN"

    

    @IBOutlet weak var card: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 15
        enteredTextField.delegate = self
        
       
    }
    
    
    @IBAction func reverseButton(_ sender: Any) {
        let temp = dropdownButton1.titleLabel!.text!
        dropdownButton1.setTitle(dropdownButton2.titleLabel!.text!, for: .normal)
        dropdownButton2.setTitle(temp, for: .normal)
    }
    @IBAction func dropdownButton1Pressed(_ sender: Any) {
        let optionsVC = OptionsTableViewController(style: .plain)
                
                // Set this view controller as the delegate
        optionsVC.delegate = self
        optionsVC.buttonNumber = 1
        
                
                // Push the options table view controller onto the navigation stack
        navigationController?.pushViewController(optionsVC, animated: true)
           
    }
    
    
    @IBAction func dropdownButton2Pressed(_ sender: Any) {
        let optionsVC = OptionsTableViewController(style: .plain)
        optionsVC.delegate = self
        optionsVC.buttonNumber = 2
        navigationController?.pushViewController(optionsVC, animated: true)
           
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let text = textField.text!
    
        let translationService = TranslationService()
        translationService.translateText(apiKey: apiKey, text: text, targetLanguage: targetLanguage, sourceLanguage: sourceLanguage) { result in
            switch result {
            case .success(let translationResponse):
                let translations = translationResponse.translations
                if let translation = translations.first {
                    print("Detected Source Language: \(translation.detected_source_language)")
                    print("Translated Text: \(translation.text)")
                    DispatchQueue.main.async {
                        self.translatedTextField.text = translation.text
                    }
                } else {
                    print("No translations found")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        return true
    }
    
   
    
    func sendDataBack(data: String) {
            // Handle the data received from the second view controller
            print(data)
        }
        
       

   
}
