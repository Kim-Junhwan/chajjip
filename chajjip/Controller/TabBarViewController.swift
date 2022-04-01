//
//  TabBarViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/25.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tapBarTintColorSetting()
    }
    
    func tapBarTintColorSetting(){
        tabBar.barTintColor =  UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.00)
    }

}

extension TabBarViewController : UITabBarControllerDelegate{
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title!{
        case "홈":
            index = 0
        case "맛집":
            index = 1
        case "관광지":
            index = 2
        case "my 리뷰":
            index = 3
        case "QR/바코드":
            index = 4
        default:
            index = 0
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if UserDefaults.standard.bool(forKey: "status"){
            if index == 4{
                performSegue(withIdentifier: "barcode", sender: nil)
                return false
            }
            return true
        }else{
            switch index{
            case 3,4:
                performSegue(withIdentifier: "login", sender: nil)
                return false
            default :
                return true
            }
        }
    }
}
