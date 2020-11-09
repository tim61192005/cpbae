//
//  ForgetViewController.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/5.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit

class ForgetViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    //隱藏StatusBar
       override var prefersStatusBarHidden: Bool {
           return true
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        print("Send Button Tapped")
        
        let Email = mailTextField.text
        
        if(mailTextField.text?.isEmpty)!
        {
            displayMessage(title:"注意", userMessage:"請輸入Email")
            return
        }
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        
        
        let mailString = String(mailTextField.text!)
        
        let myUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/api/user/send?email=\(String(describing: mailString))")
        
        print("https://sc2.sce.pccu.edu.tw/cpbae/api/user/send?email=\(String(describing: mailString))")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        
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
                    
                    
                    let message = parseJSON["popout"] as? String
                    print("popout: \(String(describing: message!))")
                    
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
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel button tapped")
        
        self.dismiss(animated: true, completion: nil)
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
