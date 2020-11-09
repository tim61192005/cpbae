//
//  HomePageViewController.swift
//  UserRegistrationExample
//

import UIKit
import SwiftKeychainWrapper
import SwiftUI

class ExpandableViewHp: UIView {
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

class HomePageViewController: BaseViewController, UISearchBarDelegate{
    
//   //隱藏StatusBar
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
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
        
        addSlideMenuButton()
        // Expandable area.
               let expandableView = ExpandableView()
              
        
        // Search button.

              
               navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "搜尋-2"), style: .plain,  target: self, action: #selector(toggle))
                      navigationItem.rightBarButtonItem?.tintColor = UIColor.darkText
                      
        
        let plainData = accessToken
        print("這個是homepage的plainData :" ,plainData as Any)
        let base64String = plainData?.base64EncodedString()
//                print("這個是homepage的encoded :" + base64String!)
        let decodedData = Data(base64Encoded: base64String!)
        let decodedString = String(data: decodedData!, encoding: .utf8)
        //        print("這個是homepage的decoded :" + decodedString!)
        let tokenString = String(decodedString!)
        super.viewDidLoad()
        self.pageWebView = UIWebView(frame: self.view.bounds)
        //給他登出
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        
        
        
        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=")
        //        let plainData = token.data(using: .utf8)
        //               let base64String = plainData?.base64EncodedString()
        //               print("這個是第二頁encoded :" + base64String!)
        //
        //               if let decodedData = Data(base64Encoded: base64String!),
        //                  let decodedString = String(data: decodedData, encoding: .utf8) {
        //                 print("這個是第二頁decoded :" + decodedString) // foo
        //               }
        
        
        //        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae?token=\(String(describing: accessToken))")
        
        //        print("實際跑出來是這樣子的拉：" + "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=")
        
        
        
        //        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: base64String))&path=")
        
        //        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=MDA4YmNjMDM2YWQwNGQ5My4lejEwTGNjajdBJXoxM0VwdGljbTQ4SEtSOWdEbWRZQ0xXTFYyJXoxM04lejEzRiV6MTNPcWNJJXoxMEprRWdtNWpRSUZxWThVTThhdU1VOFNaZ0tHbHdwZTJ1T1d4NFZRRHpiVVlKS1E2VGhORE4lejEzQVVlazVTYlpHWmVJSzM4Z04xUlZVRFZtbFJoclA1RllKS1hwTU52MkJ6YThpN0d1QWRmYmpNV2VkUG1NaEU3YVc5TmFLd2l0YXRiaUJFMjlJcFFoM1VHRU5zU1dXVjhkRVh6UDJYQjJJNFBxSWtYMWhIcnJZZ3dGeHFnb3BxaVdvJXoxMFZyWVd5TU4lejEwdUtVNkolejEwQWglejEzQ0Q2V3RPcHpOdTVhdm9SJXoxMFNWUDglejEzQ3Z4MEh4WGhRMWNQM0lhdyV6MDklejA5LjBEMkM5NkFBRDEzQUUzRERDQzc2RDJDOUVEQkVDODY4QkI0MjdGNDRGMUIxQjQ2MTk3MTk2MzI1MjY5NEI0N0E=&path=")
        
        let request = URLRequest(url: webUrl!)
        self.pageWebView?.loadRequest(request)
        
        
        
        //設定WebView格式
        pageWebView?.frame = .zero
        self.view.addSubview(pageWebView!)
        
        pageWebView!.translatesAutoresizingMaskIntoConstraints = false
        
        let ctLeft = NSLayoutConstraint(item: pageWebView as Any, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 1)
        
        let ctRight = NSLayoutConstraint(item: pageWebView as Any, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 1)
        
        let ctTop = NSLayoutConstraint(item: pageWebView as Any, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 30)
        
        let ctBottom = NSLayoutConstraint(item: pageWebView as Any, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -20)
        
        
//        let ctWidth = NSLayoutConstraint(item: pageWebView as Any, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
        
//        self.view.addConstraint(ctWidth)
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

        pageWebView?.scrollView.addSubview(refreshControl)
        
        
    }
    //系統內建要的
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

  
    //挑轉頁面
//    let searchPage = self.storyboard?.instantiateViewController(identifier: "SerchViewController") as! SerchViewController
//    let appDelegate = UIApplication.shared.delegate
//    appDelegate?.window??.rootViewController = searchPage
    
                           
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

                                   print("https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(String(describing: searchString))")
//
                                   var webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?text=\(String(describing:searchString))")
//
//
//
//                           //        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/redirect?token=\(String(describing: tokenString))&path=search?")
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
//                                   註解下列程式碼可以關閉網頁
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
     @objc func refresh(sender:AnyObject) {
                   pageWebView?.reload()
                   refreshControl.endRefreshing()
               }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        pageWebView?.goBack()
        
//        let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/")
//        let request = URLRequest(url: webUrl!)
//        self.pageWebView?.loadRequest(request)
    }
    
    
    
       }


     


