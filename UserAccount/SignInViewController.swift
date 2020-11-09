//
//  SignInViewController.swift
//  UserRegistrationExample
//
//  Created by Sergey Kargopolov on 2017-08-21.
//  Copyright © 2017 Sergey Kargopolov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    //隱藏StatusBar
       override var prefersStatusBarHidden: Bool {
           return true
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        userPasswordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        print("Sign in button tapped")
        
        
        let Account = userNameTextField.text
        let Password = userPasswordTextField.text
        
        // 確保資料不為空
        if (Account?.isEmpty)! || (Password?.isEmpty)!
        {
            
            print("Account \(String(describing: Account)) or password \(String(describing: Password)) is empty")
            displayMessage(title:"注意！",userMessage: "請輸入帳號密碼")
            
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
        
        
        //登入
        let myUrl = URL(string: "http://140.137.200.117/cpbaeapi/AppToken/AppTokenEncode")
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let postString = ["Account": Account!, "Password": Password!] as [String: String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: [])
        } catch let error {
            print(error.localizedDescription)
            displayMessage(title:"注意！",userMessage: "Something went wrong...")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
                self.displayMessage(title:"注意！",userMessage: "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            
            //Let's convert response sent from a server side code to a NSDictionary object:
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = json {
                   
//                    if parseJSON["mss"] != nil
                    if parseJSON["msg"] as? String == "帳號或密碼錯誤"
                    {
//
                        self.displayMessage(title:"X",userMessage: "帳號密碼錯誤")
                        return
                    }
                    
                    let accessToken = parseJSON["access_token"] as? String
                    let refreshToken = parseJSON["refresh_token"] as? String
                    
                    //                    let userId = parseJSON["id"] as? String
                    //print("Access token: \(String(describing: accessToken!))")
                    
                    let saveAccessToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                    let saveRefreshToken: Bool = KeychainWrapper.standard.set(refreshToken!, forKey: "refreshToken")
                    
                    
                    print("The access token save result: \(saveAccessToken)")
                    print("The refresh token save result: \(saveRefreshToken)")
                    //                    print("The userId save result \(saveUserId)")
                    
                    if (accessToken?.isEmpty)!
                    {
                        // Display an Alert dialog with a friendly error message
                        
                        self.displayMessage(title:"注意！",userMessage: "Could not successfully perform this request. Please try again later")
                        return
                    }
                    //登入成功後要做的vvvvvvv
                    if (accessToken != nil){
                        //印出兩個Token值
//                        print("原始的AccessToken:", accessToken as Any)
//                        print("RefreshToken:", refreshToken as Any)
                        
                        let plainData = accessToken?.data(using: .utf8)
                        let base64String = plainData?.base64EncodedString()
//                        print("這個是第一頁encoded :" + base64String!)

                         let decodedData = Data(base64Encoded: base64String!)
                        let decodedString = String(data: decodedData!, encoding: .utf8)
//                        print("這個是第一頁decoded :" + decodedString!)
                        
                        
                        //                        self.displayMessage(title:"OK！",userMessage: "登入成功")
                        
                        //判斷Token是否過期
                        let expiredUrl = URL(string: "http://140.137.200.117/cpbaeapi/AppToken/AppTokenValidate")
                        
                        var request = URLRequest(url:expiredUrl!)
                        
                        request.httpMethod = "POST"// Compose a query string
                        request.addValue("application/json", forHTTPHeaderField: "content-type")
                        request.addValue("application/json", forHTTPHeaderField: "Accept")
                        
                        let postString = ["access_token": accessToken!] as [String: String]
                        
                        do {
                            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: [])
                        } catch let error {
                            print(error.localizedDescription)
                            self.displayMessage(title:"注意！",userMessage: "Something went wrong...")
                            
                        }
                        let session = URLSession.shared
                        session.dataTask(with: request) {(data,response, error) in
                            if let response = response {
                                
                                print(response)
                            }
                            if let data = data {
                                do {
                                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                                    print(json as Any)
                                } catch {
                                    print(error)
                                }
                            }
                        }.resume()
                        
                        
                        //                        let expiredToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                        //                        print("The access token is expired?: \(String(describing: expiredToken))")
                        
                        
                        //                        if (expiredToken == true){
                        //                            self.displayMessage(title:"注意！",userMessage: "要換Token囉")
                        //                            let refreshUrl = URL(string: "http://140.137.200.117/cpbaeapi/AppToken/RefreshTokenEncode")
                        //                            var request = URLRequest(url:refreshUrl!)
                        //
                        //                            request.httpMethod = "POST"// Compose a query string
                        //                            request.addValue("application/json", forHTTPHeaderField: "content-type")
                        //                            request.addValue("application/json", forHTTPHeaderField: "Accept")
                        //
                        //                            let postString = ["refresh_token": refreshToken!] as [String: String]
                        //
                        //                            do {
                        //                                request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: [])
                        //                            } catch let error {
                        //                                print(error.localizedDescription)
                        //                                self.displayMessage(title:"注意！",userMessage: "Something went wrong...")
                        //                                return
                        //                            }
                        //                            let session = URLSession.shared
                        //                            session.dataTask(with: request) {(data,response, error) in
                        //                                if let response = response {
                        //                                    print(response)
                        //
                        //                                }
                        //                                if let data = data {
                        //                                    do {
                        //                                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        //                                        print(json)
                        //                                    } catch {
                        //                                        print(error)
                        //                                    }
                        //                                }
                        //                            }.resume()
                        //
                        //                        }
                        
                        
                        
                    }
                    
                    //下一頁
                    DispatchQueue.main.async
                        {
                            self.performSegue(withIdentifier: "1ViewController", sender: self)
                            //                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "1ViewController") as! HomePageViewController
                            //                            let appDelegate = UIApplication.shared.delegate
                            //                            appDelegate?.window??.rootViewController = homePage
                    }
                    
                } else {
                    //Display an Alert dialog with a friendly error message
                    self.displayMessage(title:"注意！",userMessage: "Could not successfully perform this request. Please try again later")
                }
                
            } catch {
                
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                // Display an Alert dialog with a friendly error message
                self.displayMessage(title:"注意！",userMessage: "Could not successfully perform this request. Please try again later")
                print(error)
            }
            
            
            
            
        }
        task.resume()
        return
        
        
    }
    
    @IBAction func registerNewAccountButtonTapped(_ sender: Any) {
        print("Register account button tapped")
        
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserViewController") as! RegisterUserViewController
        
        self.present(registerViewController, animated: true)
        
    }
    
    @IBAction func forgetButtonTapped(_ sender: Any) {
        
        print("Forget button tapped")
        
        let forgetViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgetViewController") as! ForgetViewController
        
        self.present(forgetViewController, animated: true)
        
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
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
    @IBAction func fastLogin(_ sender: Any) {
        //第一組小芬的帳號
        //        userNameTextField.text = "hsfehsu@com.tw"
        //        userPasswordTextField.text = "0000"
        //第二組勁廷的帳號
        userNameTextField.text = "tim61192005@gmail.com"
        userPasswordTextField.text = "12349w"
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
    }
    
    
    
}
