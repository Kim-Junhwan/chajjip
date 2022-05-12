//
//  SearchResultViewModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/06.
//

import Foundation

class SearchResultObj{
    
}

class SearchResultViewModel{
    
    //검색 결과 리스트
    private var searchResultObjs = [SearchResultObj]()
    
    //검색된 수
    func numberOfRows() -> Int{
        return searchResultObjs.count
    }
    
    func modelAt(_ index : Int) -> SearchResultObj{
        return searchResultObjs[index]
    }
    
    init(searchResultObjs : [SearchResultObj]){
        self.searchResultObjs = searchResultObjs
    }
    
}
