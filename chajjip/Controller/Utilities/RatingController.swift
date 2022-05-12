//
//  RatingController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/07.
//

import UIKit

class RatingController: UIStackView {
    
    var ratingNum = 4
    var emptyRating = "star"
    var fillRating = "star.fill"

    
    override func draw(_ rect: CGRect) {
        let starButtons = self.subviews.filter{$0 is UIButton}
        var starTag = 1
        for button in starButtons{
            if let button = button as? UIButton{
                let buttonImage = UIImage(named: emptyRating)
                button.setImage(buttonImage, for: .normal)
                button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                button.tag = starTag
                starTag = starTag+1
            }
        }
        setStarRating(rating: ratingNum)
    }
    
    func setStarRating(rating : Int){
        self.ratingNum = rating
        let stackViews = self.subviews.filter{$0 is UIButton}
        for subView in stackViews{
            if let button = subView as? UIButton{
                if button.tag > ratingNum{
                    button.setImage(UIImage(systemName: emptyRating), for: .normal)
                }else{
                    button.setImage(UIImage(systemName: fillRating), for: .normal)
                }
            }
        }
    }

    @objc func pressed(sender : UIButton){
        setStarRating(rating: sender.tag)
    }
    
}





