//
//  ShopViewController.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/9.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import SwiftUI



class ExpandableViewShop: UIView {
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


class ShopViewController: BaseViewController ,UISearchBarDelegate, UIWebViewDelegate{
   let refreshControl: UIRefreshControl = UIRefreshControl()

    var leftConstraint: NSLayoutConstraint!
    
    let accessToken =  KeychainWrapper.standard.data(forKey: "accessToken")
    var pageWebView:UIWebView?
    
    override func viewDidLoad() {
        pageWebView?.delegate = self
        addSlideMenuButton()
         self.navigationItem.title = "購物車"
        // Expandable area.
        let expandableView = ExpandableView()
       
        let plainData = accessToken
        let base64String = plainData?.base64EncodedString()
        //        print("這個是shop的encoded :" + base64String!)
        
        let decodedData = Data(base64Encoded: base64String!)
        let decodedString = String(data: decodedData!, encoding: .utf8)
        //        print("這個是shop的decoded :" + decodedString!)
        
        
        super.viewDidLoad()
        
        
        let tokenString = String(decodedString!)
        
        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=check")
        
       
        
        
        // Search button.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "搜尋-2"), style: .plain,  target: self, action: #selector(toggle))
               navigationItem.rightBarButtonItem?.tintColor = UIColor.black
       
        
        
        self.pageWebView = UIWebView(frame: self.view.bounds)
        
        func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
//            searchBar.becomeFirstResponder()
        }
        //        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=MDA4YmNjMDM2YWQwNGQ5My4lejEwTGNjajdBJXoxM0VwdGljbTQ4SEtSOWdEbWRZQ0xXTFYyJXoxM04lejEzRiV6MTNPcWNJJXoxMEprRWdtNWpRSUZxWThVTThhdU1VOFNaZ0tHbHdwZTJ1T1d4NFZRRHpiVVlKS1E2VGhORE4lejEzQVVlazVTYlpHWmVJSzM4Z04xUlZVRFZtbFJoclA1RllKS1hwTU52MkJ6YThpN0d1QWRmYmpNV2VkUG1NaEU3YVc5TmFLd2l0YXRiaUJFMjlJcFFoM1VHRU5zU1dXVjhkRVh6UDJYQjJJNFBxSWtYMWhIcnJZZ3dGeHFnb3BxaVdvJXoxMFZyWVd5TU4lejEwdUtVNkolejEwQWglejEzQ0Q2V3RPcHpOdTVhdm9SJXoxMFNWUDglejEzQ3Z4MEh4WGhRMWNQM0lhdyV6MDklejA5LjBEMkM5NkFBRDEzQUUzRERDQzc2RDJDOUVEQkVDODY4QkI0MjdGNDRGMUIxQjQ2MTk3MTk2MzI1MjY5NEI0N0E=&path=shop?type=check")
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
        
        //下拉重整
        
       
                      refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black
                      ])

                      refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)

                      refreshControl.tintColor = UIColor.white

                      pageWebView?.scrollView.addSubview(refreshControl)    }
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
    
    
    
    @objc func refresh(sender:AnyObject) {
                   pageWebView?.reload()
                   refreshControl.endRefreshing()
               }
    
    
    override func viewWillAppear(_ animated: Bool) {
         print("重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整重整")
                          pageWebView?.reload()
                          refreshControl.endRefreshing()
    }
    
 
    private func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        switch navigationType {
        case .linkClicked:
            // Open links in Safari
            UIApplication.shared.openURL(request.url!)
            return false
        default:
            // Handle other navigation types...
            return true
        }
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


