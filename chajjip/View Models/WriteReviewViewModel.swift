//
//  WriteViewModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/08.
//

import Foundation
import UIKit

class WriteReviewViewModel {
    var writeReview = WriteReview()
    var rating : Int {
        didSet{
            writeReview.rating = rating
        }
    }
    
    var review : String{
        didSet{
            writeReview.review = review
        }
    }
    
    var reviewImages : [UIImage]{
        willSet{
            reviewImages.removeAll()
        }
        
        didSet{
            
        }
    }
    
    public init(){
        self.rating = 3
        self.review = ""
        self.reviewImages = [UIImage]()
    }
    
}
