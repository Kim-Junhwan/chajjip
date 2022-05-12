//
//  ShopImageReviewTableViewCell.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/12.
//

import UIKit

class ShopImageReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rating: MyReviewRatingController!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var reviewImageCollectionView: UICollectionView!
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
        setUpUI()
        reviewImageCollectionView.delegate = self
        reviewImageCollectionView.dataSource = self
        reviewImageCollectionView.register(MyReviewImageCollectionViewCell.nib(), forCellWithReuseIdentifier: MyReviewImageCollectionViewCell.identifier)
    }
    
    func setUpUI(){
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ShopImageReviewTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopReviewVM.reviewImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reviewImage = shopReviewVM.reviewImage[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyReviewImageCollectionViewCell.identifier, for: indexPath) as! MyReviewImageCollectionViewCell
        cell.reviewImageView.image = reviewImage
        return cell
    }
}
