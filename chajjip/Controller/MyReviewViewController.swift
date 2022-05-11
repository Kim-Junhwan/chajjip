//
//  MyReviewViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/03/31.
//

import UIKit

class MyReviewViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var writeReviewNumberLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var myReviewListTableView: UITableView!
    var myReviewManager = MyReviewManager()
    var myReviewVM : MyReviewListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        myReviewListTableView.register(UINib(nibName: "MyImageReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "myReviewCell")
        myReviewListTableView.register(UINib(nibName: "MynonImageReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "mynonImageReviewCell")
        myReviewListTableView.delegate = self
        myReviewListTableView.dataSource = self
        //myReviewListTableView.estimatedRowHeight = 285.0
        writeReviewNumberLabel.text = String(format: "%d", myReviewVM.numberOfRowsInSection())
    }
    
    func setUp(){
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.width / 2
        userName.text = User.shared.name
        myReviewManager.getMyReview { data in
            if data != nil{
                self.myReviewVM = MyReviewListViewModel(myReviewList: data)
                DispatchQueue.main.async {
                    self.myReviewListTableView.reloadData()
                }
            }
        }
        print(myReviewVM.myReviewList)
    }
}

extension MyReviewViewController : UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReviewVM.numberOfRowsInSection()
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reviewVM = self.myReviewVM.myReviewAtIndex(indexPath.row)
        if reviewVM.reviewImage.count != 0{
            print("image : \(reviewVM.reviewImage.count)")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myReviewCell", for: indexPath) as? MyImageReviewTableViewCell else {fatalError().localizedDescription}
            cell.setReview(reviewVM)
        cell.reviewTargetNameLabel.text = reviewVM.shop.name
        cell.reviewDetail.text = reviewVM.reviewText
        cell.rating.rating = reviewVM.rating
        return cell
        }else{
            print("non image : \(reviewVM.reviewImage.count)")
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "mynonImageReviewCell", for: indexPath) as? MynonImageReviewTableViewCell else {fatalError().localizedDescription}
            cell.reviewTargetNameLabel.text = reviewVM.shop.name
            cell.reviewDetail.text = reviewVM.reviewText
            cell.rating.rating = reviewVM.rating
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let reviewVM = self.myReviewVM.myReviewAtIndex(indexPath.row)
        if reviewVM.reviewImage.count != 0{
            return 285.0
        }else{
            return 135.0
        }
    }

    
}
