//
//  SearchResultCell.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/01.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
