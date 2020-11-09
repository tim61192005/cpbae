//
//  ViewOneSideMenuViewController.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/11.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit

class ViewOneSideMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBarBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
