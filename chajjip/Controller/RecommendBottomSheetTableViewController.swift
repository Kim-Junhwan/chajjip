//
//  RecommendBottomSheetTableViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/10.
//

import UIKit

class RecommendBottomSheetTableViewController: UITableViewController {
    
    var recommendShopListVM : RecommendViewModel!
    
    func getShopList(model : RecommendViewModel){
        self.recommendShopListVM = model
        print("RecommendBottomSheetTableViewController : \(self.recommendShopListVM!)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Show Recommend table")
    }
    
    
}
