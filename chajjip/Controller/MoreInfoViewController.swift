//
//  MoreInfoViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/04.
//

import UIKit

class MoreInfoViewController: UIViewController {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var background: UIView!
    
    var shopReviewManager = ShopReviewManager()
    var shopReviewVM : ShopReviewListViewModel!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: "ShopImageReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "shopImageReviewCell")
        reviewTableView.register(UINib(nibName: "ShopnonImageReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "shopnonImageReviewCell")
        setUp()
    }
    func setUp(){
        background.layer.cornerRadius = 50
        thumbnail.layer.cornerRadius = 50
        shopReviewManager.getShopReivew { data in
            self.shopReviewVM = ShopReviewListViewModel(shopReviewList: data)
            print(data)
            DispatchQueue.main.async {
                self.setShopUI()
                self.reviewTableView.reloadData()
            }
        }
    }

    func setShopUI(){
        self.name.text = shopReviewVM.shop.name
        self.address.text = shopReviewVM.shop.address
        self.contact.text = shopReviewVM.shop.contactNumber
        self.thumbnail.image = shopReviewVM.shop.shopImage
    }

}

extension MoreInfoViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopReviewVM.numOfShopReview()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shopReviewVMIndex = shopReviewVM.shopReviewAtIndex(indexPath.row)
        if shopReviewVMIndex.reviewImage.count != 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopImageReviewCell", for: indexPath) as! ShopImageReviewTableViewCell
        cell.getShopReview(shopReviewVMIndex)
        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "shopnonImageReviewCell", for: indexPath) as! ShopnonImageReviewTableViewCell
            cell.getShopReview(shopReviewVMIndex)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
}
