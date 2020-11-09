//
//  EnglishVC.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/22.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class EnglishVC: BaseViewController {
    //隱藏StatusBar
       override var prefersStatusBarHidden: Bool {
           return true
       }
let accessToken =  KeychainWrapper.standard.data(forKey: "accessToken")
    var pageWebView:UIWebView?
        
        override func viewDidLoad() {
            super.viewDidLoad()
    
            let plainData = accessToken
                    print("這個是homepage的plainData :" ,plainData as Any)
                    let base64String = plainData?.base64EncodedString()
            //                print("這個是homepage的encoded :" + base64String!)
//                    let decodedData = Data(base64Encoded: base64String!)
//                    let decodedString = String(data: decodedData!, encoding: .utf8)
//                    //        print("這個是homepage的decoded :" + decodedString!)
//                    let tokenString = String(decodedString!)
                    super.viewDidLoad()
             self.pageWebView = UIWebView(frame: self.view.bounds)
                   
                     let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/search?type=0200&sub=0201&token=?")
                   
                   
                   
                  let request = URLRequest(url: webUrl!)
                       self.pageWebView?.loadRequest(request)
                       
                       pageWebView?.frame = .zero
                       self.view.addSubview(pageWebView!)
                       
                       pageWebView!.translatesAutoresizingMaskIntoConstraints = false
                       
                       let ctLeft = NSLayoutConstraint(item: pageWebView as Any, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 1)
                       
                       let ctRight = NSLayoutConstraint(item: pageWebView as Any, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 1)
                       
                       let ctTop = NSLayoutConstraint(item: pageWebView as Any, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 50)
                       
                       let ctBottom = NSLayoutConstraint(item: pageWebView as Any, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -20)
                       
                       
                       let ctWidth = NSLayoutConstraint(item: pageWebView as Any, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
                       
                       self.view.addConstraint(ctWidth)
                       self.view.addConstraint(ctTop)
                       self.view.addConstraint(ctBottom)
                       self.view.addConstraint(ctLeft)
                       self.view.addConstraint(ctRight)
                       self.view.addConstraint(ctTop)
                       self.view.addConstraint(ctBottom)
                       //註解下列程式碼可以關閉網頁
                       self.view.addSubview(self.pageWebView!)
                       
                       // Do any additional setup after loading the view.
                   }
        override func didReceiveMemoryWarning() {
               super.didReceiveMemoryWarning()
           }
        }
        

      
