//
//  ShopnonImageReviewTableViewCell.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/12.
//

import UIKit

class ShopnonImageReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rating: MyReviewRatingController!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var userNamelabel: UILabel!
    
    var shopReviewVM : ShopReviewViewModel!
    
    func getShopReview(_ model : ShopReviewViewModel){
        self.shopReviewVM = model
        self.rating.rating = shopReviewVM.rating
        self.reviewText.text = shopReviewVM.reviewText
        self.userNamelabel.text = shopReviewVM.user.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    func setUpUI(){
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
