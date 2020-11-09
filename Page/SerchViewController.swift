//
//  SerchViewController.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/9.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import SwiftUI

class ExpandableView: UIView {
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



class SerchViewController: BaseViewController,UISearchBarDelegate {
    
     let refreshControl: UIRefreshControl = UIRefreshControl()
   //隱藏StatusBar
      override var prefersStatusBarHidden: Bool {
          return true
      }
    var leftConstraint: NSLayoutConstraint!
   //抓取accessToken
    let accessToken =  KeychainWrapper.standard.data(forKey: "accessToken")
    var pageWebView:UIWebView?
    var refController:UIRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        // Expandable area.
        let expandableView = ExpandableView()
        navigationItem.titleView = expandableView
        
       resignFirstResponder()
        
        
        // Search button.
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(toggle))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "搜尋-2"), style: .done,  target: self, action: #selector(toggle))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        // Search bar.
            let searchBar = UISearchBar()
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            expandableView.addSubview(searchBar)
            leftConstraint = searchBar.leftAnchor.constraint(equalTo: expandableView.leftAnchor)
            leftConstraint.isActive = true
            searchBar.rightAnchor.constraint(equalTo: expandableView.rightAnchor).isActive = true
            searchBar.topAnchor.constraint(equalTo: expandableView.topAnchor).isActive = true
            searchBar.bottomAnchor.constraint(equalTo: expandableView.bottomAnchor).isActive = true
            searchBar.delegate = self
           
//        searchBar.showsCancelButton = true
        
            
        
        // 搜尋欄裡面文字
        searchBar.placeholder = "搜尋"
        //標線顏色
        searchBar.tintColor = UIColor.init(displayP3Red: 0, green: 160/255, blue: 200/255, alpha: 1)
        searchBar.searchBarStyle = .minimal
        
        
        
//        print("這是搜尋內容" + "\(String(describing: searchString))")
        func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
        }
        
        
        
        //下拉重整
                     refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black
                     ])

                     refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)

                     refreshControl.tintColor = UIColor.white

                     pageWebView?.scrollView.addSubview(refreshControl)
        }
    
    
   

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        UIApplication.shared.keyWindow?.endEditing(true)
        
        
        
       
        
        //        下面是切換到搜尋頁面資料
                        let plainData = accessToken
                                let base64String = plainData?.base64EncodedString()
                        //        print("這個是search的encoded :" + base64String!)

                                let decodedData = Data(base64Encoded: base64String!)
                                let decodedString = String(data: decodedData!, encoding: .utf8)
                        //        print("這個是search的decoded :" + decodedString!)
                                let tokenString = String(decodedString!)

                        self.pageWebView = UIWebView(frame: self.view.bounds)
                       
                            
//                        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=ZmI5N2JhZDQwYjIwNDM4Zi5BUGczM0FTdkZlSjhqSmwyUnY2Ymd4WjhPWXFqQXNuU3dzYzY2S21hNUNKN0wyM2VJeWlZaFIwWFROUU03Vkl4RVJRTHMlejEzQUptdXB0bDF0VVNNbCV6MTNIb29WaCV6MTBaaWpUOCV6MTBXeThaOUlCY3NBbEg4VEhycHg4WUdLSlpPQmcyN1d0WlBhNllqOUV3UjR1MDY5dGhNekhPTWNLRUxmUm5LblA5bThvUGZBUlF5JXoxM20lejEwSnVVNnF0eXY1cGRsOHhkSmFsWHJhSUVSM0FrUSV6MTBNSEkzanRrYTBVJXoxMyV6MTNsOWxIUlVvMW1XY2JPYk9tMUZ2TXNFdGtua01ZcEhtRjFnZmdvcTZSNGNiUTlIcGZzYVd4aElka2hHVmlEUzFZdyV6MDklejA5LkM0QzcyQ0UyRjI4RjFGRTY0ODc1REUxM0RCODk3OTJEM0ZBNDdFQkQxQUZCMjYxNEZBN0IyNUUyRERFNENDNEQ=&path=search?text=%E5%9C%8B")
      
        
//         let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/search?text=國&token=ZmI5N2JhZDQwYjIwNDM4Zi5BUGczM0FTdkZlSjhqSmwyUnY2Ymd4WjhPWXFqQXNuU3dzYzY2S21hNUNKN0wyM2VJeWlZaFIwWFROUU03Vkl4RVJRTHMlejEzQUptdXB0bDF0VVNNbCV6MTNIb29WaCV6MTBaaWpUOCV6MTBXeThaOUlCY3NBbEg4VEhycHg4WUdLSlpPQmcyN1d0WlBhNllqOUV3UjR1MDY5dGhNekhPTWNLRUxmUm5LblA5bThvUGZBUlF5JXoxM20lejEwSnVVNnF0eXY1cGRsOHhkSmFsWHJhSUVSM0FrUSV6MTBNSEkzanRrYTBVJXoxMyV6MTNsOWxIUlVvMW1XY2JPYk9tMUZ2TXNFdGtua01ZcEhtRjFnZmdvcTZSNGNiUTlIcGZzYVd4aElka2hHVmlEUzFZdyV6MDklejA5LkM0QzcyQ0UyRjI4RjFGRTY0ODc1REUxM0RCODk3OTJEM0ZBNDdFQkQxQUZCMjYxNEZBN0IyNUUyRERFNENDNEQ%3D")
       
        
        let searchString = String(searchBar.text!)
               
        
        //若有中文在url內，使用addingPercentEncoding轉換文字（重要重要重要）
       guard let encodeUrlString = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
       
        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(encodeUrlString)")
        
        print("https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(encodeUrlString)")
       
        //第一種解碼
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
      
        
        
        
        
        
//        while searchBar.text == ""{
//            do{
//                 webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(String(describing:searchString))")
//            }
//                print("更新的" + "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(String(describing:searchString))")
//            }
        

    }
    
   

    @objc func toggle() {

        let isOpen = leftConstraint.isActive == true

        // Inactivating the left constraint closes the expandable header.
        leftConstraint.isActive = isOpen ? false : true

        // Animate change to visible.
        UIView.animate(withDuration: 1, animations: {
            self.navigationItem.titleView?.alpha = isOpen ? 0 : 1
            self.navigationItem.titleView?.layoutIfNeeded()
        })
    }

    
            @objc func refresh(sender:AnyObject) {
                pageWebView?.reload()
                refreshControl.endRefreshing()
            }
    
    
    
}
