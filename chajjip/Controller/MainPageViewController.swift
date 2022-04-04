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
    var weatherManager = WeatherManager()
    
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
        UserDefaults.standard.set(false, forKey: "status")
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.00)
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        naverMapView.positionMode = .direction
    }
    
    
    @IBAction func pressedSidebarButton(_ sender: UIBarButtonItem) {
        if !UserDefaults.standard.bool(forKey: "status"){
            performSegue(withIdentifier: "loginSidebar", sender: nil)
        }else{
            performSegue(withIdentifier: "profileSidebar", sender: nil)
        }
    }
}

extension MainPageViewController : WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension MainPageViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last{
//            locationManager.stopUpdatingLocation()
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            print("lat : \(naverMapView.latitude), lon : \(naverMapView.longitude)")
//            weatherManager.fetchWeather(latitude: lat, longitude: lon)
//        }
        let location : CLLocation = locations[locations.count - 1]
        let longtitude : CLLocationDegrees = location.coordinate.longitude
        let latitude : CLLocationDegrees = location.coordinate.latitude
        print("naver : x:\(naverMapView.longitude), y:\(naverMapView.latitude)")
        print("corelocation : x:\(longtitude), y:\(latitude)")
        weatherManager.fetchWeather(latitude: latitude, longitude: longtitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

