import UIKit


class RegisterUserViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var idTag: UITextField!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var phonePickerView: UIPickerView!
    @IBOutlet weak var phoneText: UITextField!
    
    //隱藏StatusBar
       override var prefersStatusBarHidden: Bool {
           return true
       }
    var id = ["身分證號","護照號碼"]
     var phone = ["行動電話","住家電話"]
    
    
    @IBAction func cancel(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func done(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTag.inputView = pickerView
        idTag.inputAccessoryView = toolBar
        idTag.text = id[0]
        idTextField.delegate = self
        nameTextField.delegate = self
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        phoneTextField.delegate = self
        phoneText.inputView = phonePickerView
        phoneText.inputAccessoryView = toolBar
        phoneText.text = phone[0]
        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        print("Sign up button tapped")
        
        // Validate required fields are not empty
        if (idTextField.text?.isEmpty)! ||
            (nameTextField.text?.isEmpty)! ||
            (emailAddressTextField.text?.isEmpty)! ||
            (passwordTextField.text?.isEmpty)! ||
            (phoneTextField.text?.isEmpty)!
        {
            // Display Alert message and return
            displayMessage(title:"注意",userMessage: "資料尚未填寫完整")
            return
        }
        
//
//        if (idTextField.text?.isEmpty)!{
//            displayMessage(title:"注意",userMessage: "身分證號 尚未填寫")
//        }else if (nameTextField.text?.isEmpty)! {
//            displayMessage(title:"注意",userMessage: "姓名 尚未填寫")
//        }else if (emailAddressTextField.text?.isEmpty)! {
//        displayMessage(title:"注意",userMessage: "Email 尚未填寫")
//        }else if (passwordTextField.text?.isEmpty)! {
//        displayMessage(title:"注意",userMessage: "密碼 尚未填寫")
//        }else if (phoneTextField.text?.isEmpty)! {
//        displayMessage(title:"注意",userMessage: "手機 尚未填寫")
//        }
        
      
        
        
        // 驗證密碼（如果要可以使用）
        //        if ((passwordTextField.text?.elementsEqual(repeatPasswordTextField.text!))! != true)
        //        {
        //            // Display alert message and return
        //            displayMessage(userMessage: "Please make sure that passwords match")
        //            return
        //        }
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        
        // Send HTTP Request to Register user
        let myUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbaeapi/user/register")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"// Compose a query string
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["idNumber": idTextField.text!,
                          "name": nameTextField.text!,
                          "email": emailAddressTextField.text!,
                          "mobile":phoneTextField.text!,
                          "password": passwordTextField.text!,
            ] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(title:"hi",userMessage: "Something went wrong. Try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
                self.displayMessage(title:"hi",userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            
            //Let's convert response sent from a server side code to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                    
                    
                    let message = parseJSON["message"] as? String
                    print("message: \(String(describing: message!))")
                    
                    if (message?.isEmpty)!
                    {
                        // Display an Alert dialog with a friendly error message
                        self.displayMessage(title:"hi",userMessage: "Could not successfully perform this request. Please try again later")
                        return
                    } else {
                        self.displayMessage(title:"注意！",userMessage: "\(String(describing: message!))")
                    }
                    
                } else {
                    //Display an Alert dialog with a friendly error message
                    self.displayMessage(title:"Alert",userMessage: "Could not successfully perform this request. Please try again later")
                }
            } catch {
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                // Display an Alert dialog with a friendly error message
                self.displayMessage(title:"hi",userMessage: "Could not successfully perform this request. Please try again later")
                print(error)
            }
        }
        
        task.resume()
        
    }
    
    
    
     func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
        {
            DispatchQueue.main.async
                {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
            }
        }
        
        
        func displayMessage(title:String,userMessage:String) -> Void {
            DispatchQueue.main.async
                {
                    let alertController = UIAlertController(title: title, message: userMessage, preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "確定", style: .default) { (action:UIAlertAction!) in
                        // Code in this block will trigger when OK button tapped.
                        print("Ok button tapped")
                        DispatchQueue.main.async
                            {
                                self.dismiss(animated: true, completion: nil)
                        }
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion:nil)
            }
        }
        
        
        @IBAction func fastWrite(_ sender: Any) {
            
            idTextField.text = "A126781636"
            nameTextField.text = "陳勁廷"
            emailAddressTextField.text = "time61192005@gmail.com"
            phoneTextField.text = "0937519696"
            passwordTextField.text = "12349w"
        }
        
        //  不懂啦
        //    func updatePickerView(name:String){
        //        for(i, id) in id.enumerated(){
        //
        //            updatePickerUI(row: i)
        //            break
        //
        //        }
        //    }
        
        func updatePickerUI(row:Int){
            pickerView.selectRow(row, inComponent: 0, animated: true)
            phonePickerView.selectRow(row, inComponent: 0, animated: true)
            
           
        }
        
        
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1

        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            if (pickerView.tag == 1){
                return id.count
            }else{
                return phone.count
            }
        }
        
                            
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           
            if (pickerView.tag == 1) {
                return id[row]
            }else{
                return phone[row]
            }
        }
       
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            //        let idTag = self.view?.viewWithTag(100) as? UITextView

            if (pickerView.tag == 1){
                 idTag?.text = id[row]
                idTextField.placeholder = "請輸入" + id[row]
            }else {
               phoneText?.text = phone[row]
                phoneTextField.placeholder = "請輸入" + phone[row]
            }
            
        }
        
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        
        
        
    }




