//
//  tabBarController.swift
//  UserRegistrationExample
//
//  Created by 陳勁廷 on 2020/6/30.
//  Copyright © 2020 Sergey Kargopolov. All rights reserved.
//

import UIKit

class tabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
   
        
        
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        
        print("你點選了TabBar" + "\(tabBar.tag)")
        
        
        
        
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
