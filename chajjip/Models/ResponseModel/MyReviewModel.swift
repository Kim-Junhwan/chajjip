//
//  MyReviewModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/10.
//

import Foundation
import UIKit

struct MyReviewModel{
    var reviewList : [Review]
}

struct Review {
    var shop : Shop
    var reviewImage : [UIImage]
    var reviewText : String
    var rating : Int
}
