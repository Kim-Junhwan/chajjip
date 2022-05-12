//
//  MyReviewManager.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/11.
//

import Foundation

class MyReviewManager{
    
    //더미 데이터
    let dummyReview = DummyData.myReview
    
    //api받을시 구현 예정
    func getMyReview(completion : @escaping (MyReviewModel)->()){
        completion(dummyReview)
    }
}
