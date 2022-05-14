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
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naverMapView.positionMode = .direction
        setUp()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    //뷰 로드시 현재 위치 기반으로 검색
    func setUp(){
        let transport = AddressToCoordinate()
        recommendManager.getRecommendShop { data in
            self.recommendVM = RecommendViewModel(shopList: data)
            transport.addressToCoordinate(model: self.recommendVM) { result in
                print("after transport \(result)")
                for item in 0..<result.shopList.count{
                    self.setMarker(lat: Double(result.shopList[item].latitude)!, lon: Double(result.shopList[item].longitude)!)
                }
            }
            self.showBottomSheetList()
        }
    }
    
    
    @IBAction func clickShowBottomSheetList(_ sender: UIButton) {
        showBottomSheetList()
    }
    
    func setMarker(lat : Double, lon : Double){
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lat, lng: lon)
        marker.mapView = self.naverMapView
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
    
    
    @IBAction func pressCurrentSearch(_ sender: UIButton) {
        var coordinate = locationManager.location?.coordinate
        searchCurrentLocation(lat: coordinate!.latitude, lon: coordinate!.longitude)
    }
    
    //현재 위치 기준 추천 가게 검색
    func searchCurrentLocation(lat : Double, lon : Double){
        print("request location lat : \(lat), lon :\(lon) search")
    }
}

extension RecommendViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else {return}
        let cor = location.coordinate
        searchCurrentLocation(lat: cor.latitude, lon: cor.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
