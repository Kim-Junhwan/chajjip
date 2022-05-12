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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("call bottom sheet")
        print("")
        showBottomSheetList()
    }
    
    
    @IBAction func clickShowBottomSheetList(_ sender: UIButton) {
        showBottomSheetList()
    }
    
    func showCurrentLocation(){
        //naverMapView.positionMode = .direction
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
        
        present(nav, animated: true, completion: nil)
    }
    
    func setUpBottomSheetUI(controller : UINavigationController){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "line.3.horizontal.decrease")
        imageView.image = image
        controller.navigationItem.titleView = imageView
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
