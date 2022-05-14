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
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        naverMapView.positionMode = .direction
        naverMapView.zoomLevel = 18.0
        naverMapView.animationDuration = 1
        searchCurrentLocation()
        setUp()
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
                    self.recommendVM.shopList[item].longitude = result.shopList[item].longitude
                    self.recommendVM.shopList[item].latitude = result.shopList[item].latitude
                }
                self.showBottomSheetList()
            }
            
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
        detailViewController.delegate = self
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
        searchCurrentLocation()
    }
    
    
    @IBAction func setCurrentLocation(_ sender: UIButton) {
        naverMapView.positionMode = .direction
    }
    
    //현재 위치 기준 추천 가게 검색
    func searchCurrentLocation(){
        var coordinate = locationManager.location?.coordinate
        print("lat: \(coordinate!.latitude), lon: \(coordinate!.longitude)")
    }
}

extension RecommendViewController : CLLocationManagerDelegate{
    func getLocationUsagePermission(){
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation = locations[locations.count - 1]
        let longtitude : CLLocationDegrees = location.coordinate.longitude
        let latitude : CLLocationDegrees = location.coordinate.latitude
        print("naver : x:\(naverMapView.longitude), y:\(naverMapView.latitude)")
        print("corelocation : x:\(longtitude), y:\(latitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .notDetermined:
            print("GPS권한 설정되지 않음")
            getLocationUsagePermission()
        case .denied:
            print("GPS권한 요청 거부됨")
            getLocationUsagePermission()
        case .authorizedWhenInUse, .authorizedAlways:
            print("GPS권한 설정됨")
            self.locationManager.startUpdatingLocation()
        default:
            print("GPS:Default")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


extension RecommendViewController : RecommendListDelegate{
    func pressRecommendList(vm: ShopInfoViewModel) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: Double(vm.latitude)!, lng: Double(vm.longitude)!))
        naverMapView.moveCamera(cameraUpdate)
    }
}
