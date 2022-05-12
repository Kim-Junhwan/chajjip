//
//  WeatherData.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/26.
//

import Foundation

struct WeatherData : Decodable{
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main : Decodable{
    let temp : Double
}

struct Weather : Decodable{
    let id : Int
    let description : String
}
