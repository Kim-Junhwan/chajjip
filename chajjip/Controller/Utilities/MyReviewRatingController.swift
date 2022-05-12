//
//  MyReviewRatingController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/11.
//

import UIKit

class MyReviewRatingController: UIStackView {
    
    var rating : Int = 1

    override func draw(_ rect: CGRect) {
        let starImage = self.subviews.filter{$0 is UIImageView}
        var starTag = 1
        for star in starImage{
            if let starImageView = star as? UIImageView{
                let starImageViewImage = UIImage(systemName: "star")
                let fillStarImageViewImage = UIImage(systemName: "star.fill")
                if star.tag > rating{
                    starImageView.image = starImageViewImage
                }else{
                    starImageView.image = fillStarImageViewImage
                }
                star.tag = starTag
                starTag += 1
            }
        }
        setStarsRating(rating: rating)
    }
    
    
    func setStarsRating(rating : Int){
        self.rating = rating
        print(rating)
        let stackSubViews = self.subviews.filter{$0 is UIImageView}
        for subView in stackSubViews{
            if let star = subView as? UIImageView{
                if star.tag > rating{
                    star.image = UIImage(systemName: "star")
                }else{
                    star.image = UIImage(systemName: "star.fill")
                }
            }
        }
    }

}
