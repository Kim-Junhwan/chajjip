//
//  ShopReviewViewModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/12.
//

import Foundation
import UIKit

struct ShopReviewListViewModel{
    
    var shopReviewList : ShopReviewResModel
    
    var shop : Shop{
        return shopReviewList.shop
    }
    
    func shopReviewAtIndex(_ index : Int) -> ShopReviewViewModel{
        let shopReview = shopReviewList.shopReview[index]
        return ShopReviewViewModel(shopReview: shopReview)
    }
    
    func numOfShopReview() -> Int{
        return shopReviewList.shopReview.count
    }
    
}

struct ShopReviewViewModel{
    var shopReview : ShopReview
    
    var user : User{
        return shopReview.user
    }
    
    var reviewText : String{
        return shopReview.reviewText
    }
    
    var reviewImage : [UIImage]{
        return shopReview.reviewImage
    }
    
    var rating : Int{
        return shopReview.rating
    }
    
}
