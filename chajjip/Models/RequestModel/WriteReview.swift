//
//  WriteReview.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/09.
//

import Foundation

class WriteReview : Codable{
    var rating : Int
    var review : String
    
    public init(){
        self.rating = 3
        self.review = ""
    }
}
