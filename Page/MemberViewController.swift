//
//  MemberViewController.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/9.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import  SwiftUI

class ExpandableViewMb: UIView {
        override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }
}

class MemberViewController: BaseViewController, UISearchBarDelegate {
   
    
//    //隱藏StatusBar
//       override var prefersStatusBarHidden: Bool {
//           return true
//       }
    var leftConstraint: NSLayoutConstraint!
    let accessToken =  KeychainWrapper.standard.data(forKey: "accessToken")
    var pageWebView:UIWebView?
    
    
    override func viewDidLoad() {
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
                let imageView = UIImageView(image: UIImage(named: "Logo"))
                imageView.frame = CGRect(x: -130, y: -20, width: 220, height: 40)
                navigationItem.titleView = UIView()
        //        imageView.backgroundColor = UIColor.blue
                navigationItem.titleView?.addSubview(imageView)
        
        super.viewDidLoad()
        addSlideMenuButton()
        // Expandable area.
               let expandableView = ExpandableView()
              
        
        // Search button.
            
              navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "搜尋-2"), style: .plain,  target: self, action: #selector(toggle))
                     navigationItem.rightBarButtonItem?.tintColor = UIColor.black
              
               
                      
        let plainData = accessToken
        let base64String = plainData?.base64EncodedString()
        //        print("這個是member的encoded :" + base64String!)
        
        let decodedData = Data(base64Encoded: base64String!)
        let decodedString = String(data: decodedData!, encoding: .utf8)
        //        print("這個mbmber頁的decoded :" + decodedString!)
        
        let tokenString = String(decodedString!)
        
        self.pageWebView = UIWebView(frame: self.view.bounds)
        //            token=\(String(describing: accessToken))
        //        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String: String(describing: accessToken?.base64EncodedString()))&path=account?type=info")
        
        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=" + "\(String(describing: tokenString))" + "&path=info")
        //        print("這個拉\(tokenString)")
        
        //                    let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=NDRjNTM1MjMwMmRmNGU0NC45QnFPR0RTMDl6TnNkNWRoZ0taQnhLMlNLUHQ3OUZUWFczRWo0c3I1eklxJXoxM0RpdDJrSkI0aU9kalAlejEzQWVrNU9VR0dlY2VjZGZPUmZhTkxkRUlUd1dyS056aWk2MzBsQnY3WHBhemhQZFhVbGQ5c1RzdkNUaGx1dGF1blpWWUNjRDI4N0J2ViV6MTBBckNzZjllcWxpUnJGWGtKN0lmY0RKQmE4VjNYQkRvYktzeEpnVk5FbkhJSnJuN0FNanQlejEzNCV6MTNqUmtabnpGd1E3OXYzeFdQTXVqNkY3NkM1djNRZzNDJXoxMHIzdWNPWFFXQ2V5MlZkQ2RtbnY4TENGQlIzTTg3anRERmUxUjJnJXoxM1ZoZ1ZmQzRxcnBWNmRaNGJ0dyV6MDklejA5LjhDQjMzOTc3MDE0M0Y4NzhDRkJCQUJDMDdERjQyQTNFQTZCQzMyQkM3MEE1NTJBNDI4QkI2Mzg4MzRBNEZGQjI=&path=info")
        let request = URLRequest(url: webUrl!)
        self.pageWebView?.loadRequest(request)
        
        pageWebView?.frame = .zero
        self.view.addSubview(pageWebView!)
        
        pageWebView!.translatesAutoresizingMaskIntoConstraints = false
        
        let ctLeft = NSLayoutConstraint(item: pageWebView as Any, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 1)
        
        let ctRight = NSLayoutConstraint(item: pageWebView as Any, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 1)
        
        let ctTop = NSLayoutConstraint(item: pageWebView as Any, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 30)
        
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
   // Do any additional setup after loading the view.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                        
                let searchString = String(searchBar.text!)
                
                //        下面是切換到搜尋頁面資料
                                let plainData = accessToken
                                        let base64String = plainData?.base64EncodedString()
                                //        print("這個是search的encoded :" + base64String!)

                                        let decodedData = Data(base64Encoded: base64String!)
                                        let decodedString = String(data: decodedData!, encoding: .utf8)
                                //        print("這個是search的decoded :" + decodedString!)
                                        let tokenString = String(decodedString!)

                                self.pageWebView = UIWebView(frame: self.view.bounds)
                               
                        //        print("https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(String(describing: searchString))")

                                var webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(String(describing:searchString))")
                                
                                
                                    
                        //        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?")
                                let request = URLRequest(url: webUrl!)
                                self.pageWebView?.loadRequest(request)

                                
                                
                                
                                pageWebView?.frame = .zero
                                self.view.addSubview(pageWebView!)

                                pageWebView!.translatesAutoresizingMaskIntoConstraints = false

                                let ctLeft = NSLayoutConstraint(item: pageWebView as Any, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 1)

                                let ctRight = NSLayoutConstraint(item: pageWebView as Any, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 1)

                                let ctTop = NSLayoutConstraint(item: pageWebView as Any, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 30)

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
                
                
                
                while searchBar.text == ""{
                    do{
                         webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(String(describing:searchString))")
                    }
                        print("更新的" + "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(String(describing:searchString))")
                    }
                

            }
            

            @objc func toggle() {
self.tabBarController!.selectedIndex = 2
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


    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */


