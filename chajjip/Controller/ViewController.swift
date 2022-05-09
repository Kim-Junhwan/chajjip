//
//  ViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/24.
//
//
import UIKit
import NMapsMap
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    //destination array
    var destination = ["강원 춘천시 백령로 25번길 6 ","강원 춘천시 백령로 25","강원 춘천시 백령로25번길 2 1층 도스마스강대점"]
    var destinationCoordinate : [Destination] = []

    @IBOutlet weak var naverMapView: NMFMapView!
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // current Location
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
        //naver map setting
        naverMapView.zoomLevel = 18.0
        naverMapView.positionMode = .direction
        
        //get destination coordinates
        for item in destination{
            let encodeAddress = item.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
            let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: NaverMapAPI.NAVER_CLIENT_ID)
            let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: NaverMapAPI.NAVER_CLIENT_SECRET)
            let headers = HTTPHeaders([header1,header2])
            AF.request(NaverMapAPI.NAVER_GEOCODE_URL + encodeAddress, method: .get, headers: headers).validate().responseJSON{response in
                switch response.result {
                case .success(let value as [String:Any]):
                    let json = JSON(value)
                    let data = json["addresses"]
                    let lat = data[0]["y"].string
                    let lon = data[0]["x"].string
                    let newDestination = Destination(address: item, longitude: lon!, latitude: lat!)
                    let marker = NMFMarker()
                    marker.position = NMGLatLng(lat: Double(newDestination.latitude)!, lng: Double(newDestination.longitude)!)
                    marker.mapView = self.naverMapView
                case .failure(let error):
                    print(error.errorDescription ?? "")
                default:
                    fatalError()
                }
            }
        }
    }
}

extension ViewController : CLLocationManagerDelegate{
    
    func getLocationUsagePermission(){
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    //get location privacy
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
    
    //get current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation = locations[locations.count - 1]
        let longtitude : CLLocationDegrees = location.coordinate.longitude
        let latitude : CLLocationDegrees = location.coordinate.latitude
        print("naver : x:\(naverMapView.longitude), y:\(naverMapView.latitude)")
        print("corelocation : x:\(longtitude), y:\(latitude)")
    }
}
