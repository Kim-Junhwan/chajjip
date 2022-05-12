//
//  MynonImageReviewTableViewCell.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/11.
//

import UIKit

class MynonImageReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var rating: MyReviewRatingController!
    @IBOutlet weak var reviewTargetNameLabel: UILabel!
    @IBOutlet weak var reviewDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5.0, left: 5, bottom: 5, right: 5))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
