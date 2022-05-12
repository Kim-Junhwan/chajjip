//
//  WeatherModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/26.
//

import Foundation

struct WeatherModel{
    let conditionId : Int
    let cityName : String
    let temperature : Double
    
    var temperatureString : String{
        String(format: "%.1f", temperature)
    }
    
    var conditionName : String{
        switch conditionId{
            case 200...232 :
                return "thunder"
            case 300...321 :
                return "rain" //cloud.drizzle
            case 500...531 :
                return "rain"
            case 600...622 :
                return "snow"
            case 701...781 :
                return "fog"
            case 800 :
                return "sun"
            case 801...804 :
                return "cloudSun"
            default:
                return "cloud"
        }
    }
    
}
