//
//  RecommendViewModel.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/06.
//

import Foundation
import UIKit

struct RecommendViewModel{
    var shopList : [Shop]
    
    func shopAtIndex(_ index : Int) -> ShopInfoViewModel{
        return ShopInfoViewModel(model: shopList[index])
    }
    
    func numOfShopList()->Int{
        return shopList.count
    }
}

struct ShopInfoViewModel{
    var shop : Shop
    init(model : Shop){
        self.shop = model
    }
    
    var name : String{
        return shop.name
    }
    
    var address : String{
        return shop.address
    }
    
    var shopImage : UIImage{
        return shop.shopImage
    }
    
    var contact : String{
        return shop.contactNumber
    }
}
