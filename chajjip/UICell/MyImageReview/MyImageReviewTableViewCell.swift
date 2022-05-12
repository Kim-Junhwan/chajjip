//
//  MyReviewTableViewCell.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/09.
//

import UIKit

class MyImageReviewTableViewCell: UITableViewCell{
    
    @IBOutlet weak var rating: MyReviewRatingController! 
    @IBOutlet weak var reviewTargetNameLabel: UILabel!
    @IBOutlet weak var reviewDetail: UILabel!
    @IBOutlet weak var reviewImageCollectionView: UICollectionView!
    var myReviewViewModel : MyReviewViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        reviewImageCollectionView.register(MyReviewImageCollectionViewCell.nib(), forCellWithReuseIdentifier: MyReviewImageCollectionViewCell.identifier)
        reviewImageCollectionView.delegate = self
        reviewImageCollectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5.0, left: 5, bottom: 5, right: 5))
    }
    
    public func setReview(_ model : MyReviewViewModel){
        self.myReviewViewModel = model
    }
}

extension MyImageReviewTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myReviewViewModel.reviewImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reviewImage = myReviewViewModel.myReviewImageAtIndex(indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyReviewImageCollectionViewCell.identifier, for: indexPath) as! MyReviewImageCollectionViewCell
        cell.reviewImageView.image = reviewImage
        return cell
    }
}

extension MyImageReviewTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
