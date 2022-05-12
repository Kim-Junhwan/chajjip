//
//  MyReviewViewModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/06.
//

import Foundation
import UIKit

struct MyReviewListViewModel {
    var myReviewList : MyReviewModel
    
    func myReviewAtIndex(_ index : Int) -> MyReviewViewModel{
        let myReview = self.myReviewList.reviewList[index]
        return MyReviewViewModel(myReview)
    }
    
    func numberOfRowsInSection() -> Int{
        return myReviewList.reviewList.count
    }
}

struct MyReviewViewModel{
    var myReview : Review
    
    init(_ myReview : Review){
        self.myReview = myReview
    }
    
    var shop : Shop {
        return self.myReview.shop
    }
    
    var reviewText : String{
        return self.myReview.reviewText
    }
    
    var rating : Int {
        return self.myReview.rating
    }
    
    var reviewImage : [UIImage]{
        return self.myReview.reviewImage
    }
    
    public func myReviewImageAtIndex(_ index : Int) -> UIImage{
        let reviewImage = self.reviewImage[index]
        return reviewImage
    }
}
