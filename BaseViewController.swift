//
//  BaseViewController.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/17.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
   
    
//    func slideMenuItemSelectedAtIndex(sections: String) {
//        let topViewcontroller : UIViewController = self.navigationController!.topViewController!
//        print("嘿嘿嘿嘿view controller is : \(topViewcontroller) \n", terminator: "")
//        switch (sections) {
//        case "課程總覽":
//            self.openViewControllerBasedOnIdentifier("MenuOneVC")
//            break
//        case 1:
//            print("國際語文\n", terminator:"")
//            self.openViewControllerBasedOnIdentifier("MenuTwoVC")
//        case 2:
//            print("專業進修\n", terminator:"")
//            self.openViewControllerBasedOnIdentifier("MenuTwoVC")
//        case 3:
//            print("委訓合作\n", terminator:"")
//            self.openViewControllerBasedOnIdentifier("MenuTwoVC")
//        case 4:
//            print("場地空間\n", terminator:"")
//            self.openViewControllerBasedOnIdentifier("MenuTwoVC")
//        default:
//            print("default\n", terminator:"")
//        }
//    }
    
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
            let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
//            let topViewController : UIViewController = self.navigationController!.topViewController!
//            if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
//                print("Same VC")
//            } else {
                self.navigationController!.pushViewController(destViewController, animated: true)
//            }
        }
        func addSlideMenuButton(){
            let btnShowMenu = UIButton(type: UIButton.ButtonType.system)
            btnShowMenu.setImage(UIImage(named: "選單"), for: UIControl.State())
            btnShowMenu.tintColor = UIColor.black
            btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
            let customBarItem = UIBarButtonItem(customView: btnShowMenu)
            self.navigationItem.leftBarButtonItem = customBarItem;
        }
        

    
    
        @objc func onSlideMenuButtonPressed(_ sender : UIButton){
            if (sender.tag == 10)
            {
                // To Hide Menu If it already there
//                self.slideMenuItemSelectedAtIndex(-1);
                sender.tag = 0;
                let viewMenuBack : UIView = view.subviews.last!
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    var frameMenu : CGRect = viewMenuBack.frame
                    frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                    viewMenuBack.frame = frameMenu
                    viewMenuBack.layoutIfNeeded()
                    viewMenuBack.backgroundColor = UIColor.clear
                    }, completion: { (finished) -> Void in
                        viewMenuBack.removeFromSuperview()
                })
                return
            }
            sender.isEnabled = false
            sender.tag = 10
            let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            menuVC.btMenu = sender
//            menuVC.delegate = self
            self.view.addSubview(menuVC.view)
            self.addChildViewController(menuVC)
            menuVC.view.layoutIfNeeded()
            menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
                sender.isEnabled = true
                }, completion:nil)
        }
    
    }
