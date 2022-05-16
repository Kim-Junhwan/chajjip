//
//  MainPageViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/25.
//

import Foundation
import UIKit
import CoreLocation
import NMapsMap

class MainPageViewController : UIViewController{
    
    //weather view
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureSign: UILabel!
    @IBOutlet weak var temperatureSignTwo: UILabel!
    @IBOutlet weak var pedoMeterView: UIView!
    @IBOutlet weak var pedoMeterImageView: UIImageView!
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var walkingRunningDistanceLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var pedoManager = PedoMeterManager()
    var visitedShopManager = VisitedShopManager()
    var visitedShopVM : RecommendViewModel!
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    //navermapView
    @IBOutlet weak var naverMapView: NMFMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.set(false, forKey: "status")
        setUp()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.00)
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        //다녀온 여행지에 현재위치 추가할지는 고려사항
        //naverMapView.positionMode = .direction
        pedoManager.getStepCount { result in
            self.stepCountLabel.text = String(format: "%.0f", result)
        }
        pedoManager.getDistanceWalkingRunning { result in
            self.walkingRunningDistanceLabel.text = String(format: "%.3f", result)
        }
    }
    
    func setUp(){
        let navBarAppearance = UINavigationBarAppearance()
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        //self.UIBarButtonItem.appearance().tintColor = UIColor.white
        weatherView.layer.cornerRadius = 10
        conditionImageView.layer.cornerRadius = 10
        pedoMeterView.layer.cornerRadius = 10
        pedoMeterImageView.layer.cornerRadius = 10
        
        //temperature label shadow
        temperatureLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        temperatureLabel.layer.shadowOpacity = 0.8
        temperatureLabel.layer.shadowRadius = 2
        temperatureLabel.layer.shadowColor = UIColor.black.cgColor
        
        temperatureSign.layer.shadowOffset = CGSize(width: 3, height: 3)
        temperatureSign.layer.shadowOpacity = 0.8
        temperatureSign.layer.shadowRadius = 2
        temperatureSign.layer.shadowColor = UIColor.black.cgColor
        
        temperatureSignTwo.layer.shadowOffset = CGSize(width: 3, height: 3)
        temperatureSignTwo.layer.shadowOpacity = 0.8
        temperatureSignTwo.layer.shadowRadius = 2
        temperatureSignTwo.layer.shadowColor = UIColor.black.cgColor
        
        //access healthData
        pedoManager.requestAuthorization()
    }
    
    @IBAction func pressedSidebarButton(_ sender: UIBarButtonItem) {
            performSegue(withIdentifier: "showSideMenu", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CustomSideMenuNavigation{
            guard let vc = segue.destination as? CustomSideMenuNavigation else {return}
            vc.customDelegate = self
        }
    }
}

extension MainPageViewController : WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(named: weather.conditionName)//UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension MainPageViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        let realtimeLocation : CLLocation = locations[locations.count - 1]
//        let longtitude : CLLocationDegrees = realtimeLocation.coordinate.longitude
//        let latitude : CLLocationDegrees = realtimeLocation.coordinate.latitude
//        print("naver : x:\(naverMapView.longitude), y:\(naverMapView.latitude)")
//        print("corelocation : x:\(longtitude), y:\(latitude)")
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MainPageViewController : CustomSideMenuNavigationDelegate{
    func showSideMenu() {
        let transport = AddressToCoordinate()
        visitedShopManager.getVisitedShopList(user: User.shared) { result in
            self.visitedShopVM = RecommendViewModel(shopList: result)
            transport.addressToCoordinate(model: self.visitedShopVM) { result in
                print("after transport \(result)")
                for item in 0..<result.shopList.count{
                    self.setMarker(lat: Double(result.shopList[item].latitude)!, lon: Double(result.shopList[item].longitude)!)
                    self.visitedShopVM.shopList[item].longitude = result.shopList[item].longitude
                    self.visitedShopVM.shopList[item].latitude = result.shopList[item].latitude
                }
                //좌표들의 중앙값 계산후 카메라 위치 이동
                self.getMiddleCameraLocation()
            }
            
        }
        
    }
    
    func setMarker(lat : Double, lon : Double){
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lat, lng: lon)
        marker.mapView = self.naverMapView
    }
    
    func getMiddleCameraLocation(){
        var sumLon = 0.0
        var sumLat = 0.0
        for item in visitedShopVM.shopList{
            sumLon += Double(item.longitude)!
            sumLat += Double(item.latitude)!
        }
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: sumLat / Double(visitedShopVM.shopList.count), lng: sumLon / Double(visitedShopVM.shopList.count) ))
            naverMapView.moveCamera(cameraUpdate)
            naverMapView.zoomLevel = 12.0
    }
}
