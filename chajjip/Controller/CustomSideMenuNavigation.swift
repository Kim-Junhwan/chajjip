//
//  CustomSideMenuNavigation.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/07.
//

import Foundation
import SideMenu

protocol CustomSideMenuNavigationDelegate{
    func showSideMenu()
}

class CustomSideMenuNavigation : SideMenuNavigationController{
    
    var customDelegate : CustomSideMenuNavigationDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentationStyle = .menuSlideIn
        self.menuWidth = self.view.frame.width * 0.7
        let rootVC = self.viewControllers.first as? SideMenuViewController
        rootVC?.delegate = self
//        if let navVC = storyboard?.instantiateViewController(withIdentifier: "customSideNav") as? CustomSideMenuNavigation, let rootVC = navVC.viewControllers.first as? SideMenuViewController{
//            rootVC.delegate = self
//        }
    }
    
    func setUpBarColor(){
        let myColor = UIColor.systemBackground
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = myColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}

extension CustomSideMenuNavigation : SideMenuDelegate{
    func successLogin() {
        customDelegate.showSideMenu()
    }
}
