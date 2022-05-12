//
//  WeatherManager.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/26.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error : Error)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    var delegate : WeatherManagerDelegate?
    
    let myOpenWeatherApiKey = "462c4e7edfd0874d7f9c5eba541e3eb2"
    
    func fetchWeather(latitude : Double, longitude: Double){
        let urlString = "\(weatherURL)lat=\(latitude)&lon=\(longitude)&appid=\(myOpenWeatherApiKey)&units=metric"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString : String){
        if let url = URL(string: urlString){
            AF.request(url, method: .get).validate().responseJSON{ response in
                switch response.result{
                case .success(let value as [String : Any]):
                    if let weather = parseJSON(weatherData: value){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                case .failure(let error):
                    print(error.errorDescription ?? "")
                default:
                    fatalError()
                }
            }
        }
    }
    
    func parseJSON(weatherData : [String: Any])->WeatherModel?{
        let safeData = JSON(weatherData)
        let data = safeData["weather"]
        let id = data[0]["id"].int
        let temp = safeData["main"]["temp"].double
        let name = safeData["name"].string
        let weather = WeatherModel(conditionId: id!, cityName: name!, temperature: temp!)
        return weather
    }
}
