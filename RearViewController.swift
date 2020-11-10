//
//  RearViewController.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/11.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit

class RearViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openViewOneBtn(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "openViewOneSegue", sender: self)
        HamburgerMenu().closeSideMenu()
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
