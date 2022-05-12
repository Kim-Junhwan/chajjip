//
//  Constants.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/24.
//

import Foundation

struct NaverMapAPI{
    static let NAVER_CLIENT_ID = "nr388t370w"
    static let NAVER_CLIENT_SECRET = "BsNKJKsqeT4JNi9wm27XYvxJ81KB7qsNjj5fHtJ6"
    static let NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
}

//테스트용 api, 변경 필요
struct API{
    static let BASE_URL = "https://d5bb68b8-d619-4842-97b5-771793b4f914.mock.pstmn.io/testapi/"
    static let register_URL = "\(BASE_URL)registerUser"
    static let login_URL = "\(BASE_URL)loginUser"
    static let search_URL = "\(BASE_URL)search/"
    
    static func urlForSearchByText(text : String) -> URL{
        return URL(string: "\(search_URL)/\(text)")!
    }
}
