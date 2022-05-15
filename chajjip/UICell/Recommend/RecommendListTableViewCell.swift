//
//  RecommendListTableViewCell.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/11.
//

import UIKit

protocol RecommendTableViewDelegate{
    func showMoreInfoView(shop : Shop)
}

class RecommendListTableViewCell: UITableViewCell {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    var shop : Shop?
    var delegate : RecommendTableViewDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        addressLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressMoreInfo(_ sender: UIButton) {
        guard let shop = shop else {return}
        print("Cell shop \(shop)")
        delegate.showMoreInfoView(shop : shop)
    }
}
