//
//  ShopDetailreviewResModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/12.
//

import Foundation
import UIKit

struct ShopReviewResModel{
    var shop : Shop
    var shopReview : [ShopReview]
}

struct ShopReview{
    var user : User
    var reviewImage : [UIImage]
    var reviewText : String
    var rating : Int
}
