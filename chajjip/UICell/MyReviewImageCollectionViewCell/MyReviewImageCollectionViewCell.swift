//
//  MyReviewImageCollectionViewCell.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/12.
//

import UIKit

class MyReviewImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reviewImageView: UIImageView!
    
    static let identifier = "MyReviewImageCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MyReviewImageCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
