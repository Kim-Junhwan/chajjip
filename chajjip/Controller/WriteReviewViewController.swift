//
//  WriteReviewViewController.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/04/04.
//

import UIKit
import BSImagePicker
import Photos

class WriteReviewViewController: UIViewController {
    @IBOutlet weak var rating: RatingController!
    @IBOutlet weak var reviewTextField: UITextView!
    private let vm = WriteReviewViewModel()
    
    
    var reviewImageList : [UIImage] = []
    @IBOutlet weak var reviewImageCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        //setting reviewTextField
        reviewTextField.layer.borderWidth = 1.0
        reviewTextField.layer.borderColor = UIColor.black.cgColor
        reviewTextField.layer.cornerRadius = 10
        reviewTextField.delegate = self
        reviewTextField.text = "다녀왔던 여행지나 식당에 대해 추천하는 내용이나 솔직한 리뷰를 작성해주세요. 악플성 글, 리뷰와 관련이 없다고 의심 또는 판단 되는 글은 예고없이 삭제 뢸 수 있습니다."
        reviewTextField.textColor = UIColor.lightGray
        
        //set reviewImageCollectionView Delegate, Datasource setting
        reviewImageCollectionView.delegate = self
        reviewImageCollectionView.dataSource = self
        //reviewTextField Delegate setting
        reviewTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func pressedBackButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - 완료버튼 클릭
    @IBAction func pressCompleteButton(_ sender: UIBarButtonItem) {
        vm.rating = rating.ratingNum
        
    }
    
    
    func pressAddButton(){
        let imagePicker = ImagePickerController()
        imagePicker.settings.selection.max = 3
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        
        presentImagePicker(imagePicker, animated: true, select: { asset in
            
        }, deselect: { (asset) in
            
        }, cancel: { (asset) in
            
        }, finish: { (asset) in
            self.convertAssetToImage(asset: asset)
        }, completion: nil)
    }
    
    //MARK: - PHAImage를 UIImage로 변환 및 리스트에 추가
    func convertAssetToImage(asset : [PHAsset]){
        if asset.count != 0{
            for item in 0..<asset.count{
                let imageManager = PHImageManager.default()
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                var thumbnail = UIImage()
                imageManager.requestImage(for: asset[item], targetSize: CGSize(width: 128, height: 128), contentMode: .aspectFill, options: option) { (result, info) in
                    thumbnail = result!
                }
                let data = thumbnail.jpegData(compressionQuality: 0.7)
                let newImage = UIImage(data: data!)
                vm.reviewImages.append(newImage! as UIImage)
            }
        }
        self.reviewImageCollectionView.reloadData()
    }
}

extension WriteReviewViewController : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "내용을 입력해주세요."
            textView.textColor = UIColor.lightGray
        }
        vm.review = textView.text
    }
}

extension WriteReviewViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.reviewImages.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addReviewImage", for: indexPath) as! AddReviewImageCollectionViewCell
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewImage", for: indexPath) as? WriteReviewImageCollectionViewCell else{fatalError("Failed to deque cell for reviewImagePicer")}
            cell.reviewImageView.image = vm.reviewImages[indexPath.row-1]
            cell.delegate = self
            cell.indexPath = indexPath.row
        return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            //앨범에서 사진 추가
            print("press \(indexPath.row)")
            pressAddButton()
        }
    }
}

extension WriteReviewViewController : UICollectionViewDelegateFlowLayout{
    //셀 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //셀사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 1
        let size = CGSize(width: 128, height: 128)
        return size
    }
}

extension WriteReviewViewController : ReviewImageCellDelegate{
    func pressDeleteReviewImageButton(at index: Int) {
        vm.reviewImages.remove(at: index - 1)
        reviewImageCollectionView.reloadData()
    }
}

