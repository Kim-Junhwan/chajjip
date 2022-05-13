//
//  RecommendViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/10.
//

import UIKit
import MaterialComponents
import NMapsMap

class RecommendViewController: UIViewController {
    
    @IBOutlet weak var naverMapView: NMFMapView!
    
    var recommendManager = RecommendShopManager()
    var recommendVM : RecommendViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //뷰 로드시 현재 위치 기반으로 검색
    func setUp(){
        recommendManager.getRecommendShop { data in
            self.recommendVM = RecommendViewModel(shopList: data)
            self.showBottomSheetList()
        }
    }
    
    
    @IBAction func clickShowBottomSheetList(_ sender: UIButton) {
        showBottomSheetList()
    }
    
    func showCurrentLocation(){
        naverMapView.positionMode = .direction
    }
    
    
    func showBottomSheetList(){
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "recommendList") as! RecommendBottomSheetTableViewController
        let nav = UINavigationController(rootViewController: detailViewController)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        detailViewController.navigationItem.title = "추천"
        detailViewController.getShopList(model: recommendVM)
        present(nav, animated: true, completion: nil)
    }
    
    func setUpBottomSheetUI(controller : UINavigationController){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "line.3.horizontal.decrease")
        imageView.image = image
        controller.navigationItem.titleView = imageView
    }
}
