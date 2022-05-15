//
//  ShopReviewManager.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/12.
//

import Foundation

class ShopReviewManager{
    
    let dummyShopReview = DummyData.shopReview
    
    func getShopReivew(shop : Shop ,completion : @escaping (ShopReviewResModel)->()){
        completion(dummyShopReview)
    }
    
}
