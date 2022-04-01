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
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "status")
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.00)
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
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
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("lat : \(lat), lon : \(lon)")
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

