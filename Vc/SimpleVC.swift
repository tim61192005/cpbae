//
//  SimpleVC.swift
//  
//
//  Created by 陳勁廷 on 2020/6/20.
//

import UIKit
import SwiftKeychainWrapper

class SimpleVC: BaseViewController {
    
    
    var webURL: String!
    
 
   
    let accessToken = KeychainWrapper.standard.data(forKey: "accessToken")
    var pageWebView:UIWebView?
    
    
    override func viewDidLoad() {
        let plainData = accessToken
                    print("測試測試測試測試試測",plainData as Any)
                    let base64String = plainData?.base64EncodedString()
        //            print("測試測試測試測試測試" + base64String!)
       
        super.viewDidLoad()
        //        self.movieImage.image = UIImage(named: imageName)
        self.pageWebView = UIWebView(frame: self.view.bounds)
        
          let webUrl = URL(string: "https://sc2.sce.pccu.edu.tw/cpbae/search?type=0100&sub=0100")
        
        
        
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
    func setWebView(webURL:String){
        
//        self.webURL = "yahoo.com.tw"
        
    }
    
//    func customInit(imageName:String){
//        self.imageName = imageName
//        
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
