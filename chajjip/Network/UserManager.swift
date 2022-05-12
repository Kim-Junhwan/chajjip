//
//  UserManager.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/05.
// 로그인, 회원가입등 User 로직 클래스

import Foundation
import Alamofire

class UserManager{
    
    //MARK: - singleton
    static let shared : UserManager = UserManager()
    
    //MARK: - USER Request API
    let loginRequestURL = API.BASE_URL
    let registerRequestURL = API.register_URL
    
    func register(model : RegisterReqModel, completion : @escaping (Bool) -> () ){
        let headers : HTTPHeaders = [
            .contentType("application/json; charset=UTF-8"), .accept("application/json; charset=UTF-8")
        ]
        AF.request(registerRequestURL, method: .post, parameters: model, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    //let getData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    //let parsingJson = try JSONDecoder().decode(RegisterResModel.self, from: getData)
                    //print("data : \(json)")
                    //print("parsing json: \(getData)")
                    if response.response?.statusCode == 200 {
                        completion(true)
                    }else{
                        completion(false)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func login(model : LoginReqModel){
        let headers : HTTPHeaders = [
            .contentType("application/json; charset=UTF-8"), .accept("application/json; charset=UTF-8")
        ]
    }
    
    
}

extension UserManager {
    //로그인 or 자동로그인을 실행할떄마다 자동으로 실행되서 shared에 유저 정보 담기
    func saveUserInfo(model : User){
        User.shared.name = model.name
        User.shared.phoneNumber = model.phoneNumber
        User.shared.age = model.age
        User.shared.password = model.password
        User.shared.email = model.email
    }
}

/*
 AF.request(registerRequestURL, method: .post, parameters: model.parameters, encoding:URLEncoding.httpBody, headers: model.headers).responseJSON{(response) in
     guard let statusCode = response.response?.statusCode else {return}
     switch statusCode {
     case 200..<300:
         do{
             let decodedData = try JSONDecoder().decode(RegisterResModel.self, from: response.data!)
             
         } catch{
             print("JSON Decoding ERROR")
         }
     default:
         if let responseJSON = try! response.result.get() as? [String : String]{
             if let error = responseJSON["error"]{
                 print(error)
             }
         }
     }
 }
 */
