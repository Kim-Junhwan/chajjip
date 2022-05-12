//
//  WriteReviewImageCollectionViewCell.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/08.
//

import UIKit

protocol ReviewImageCellDelegate{
    func pressDeleteReviewImageButton(at index : Int)
}

class WriteReviewImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reviewImageView: UIImageView!
    var delegate : ReviewImageCellDelegate!
    var indexPath = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func pressDeleteReviewImage(_ sender: UIButton) {
        delegate.pressDeleteReviewImageButton(at: indexPath)
    }
}
