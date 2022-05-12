//
//  RegisterReqModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/05.
//

import Foundation
import Alamofire

struct RegisterReqModel : Encodable{
    var name : String
    var email : String
    var password : String
    
    init(name : String, email : String, password : String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
}
