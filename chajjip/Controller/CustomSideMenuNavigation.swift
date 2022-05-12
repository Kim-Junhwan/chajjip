//
//  CustomSideMenuNavigation.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/07.
//

import Foundation
import SideMenu

class CustomSideMenuNavigation : SideMenuNavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentationStyle = .menuSlideIn
        self.menuWidth = self.view.frame.width * 0.7
        //setUpBarColor()
    }
    
    func setUpBarColor(){
        let myColor = UIColor.systemBackground
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = myColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    
}
