//
//  User.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/30.
//

import Foundation

struct User{
    //singleton User
    static var shared : User = User()
    
    var name : String
    var email : String
    var password : String
    var age : Int
    var sex : Bool
    var phoneNumber : String
    
    init(){
        self.name = ""
        self.email = ""
        self.password = ""
        self.age = 0
        self.sex = false
        self.phoneNumber = ""
    }
    
    init(name : String , email : String, password : String, age : Int, sex : Bool, phoneNumber : String){
        self.name = name
        self.email = email
        self.password = password
        self.age = age
        self.sex = sex
        self.phoneNumber = phoneNumber
    }
}
