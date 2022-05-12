//
//  SearchResModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/06.
//
//MARK: - 검색 목록 응답 모델
import Foundation

struct SearchResponse{
    let tourists : [Tourist]
}

struct Tourist{
    var name : String
    var address : String
    var contact : String
}
