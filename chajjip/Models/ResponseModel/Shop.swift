//
//  Shop.swift
//  chajjip
//
//  Created by JunHwan Kim on 2022/05/11.
//

import Foundation
import UIKit

struct ShopList{
    var shopList : [Shop]
}

struct Shop{
    var name : String
    var address : String
    var contactNumber : String
    var shopImage : UIImage
    var longitude : String = ""
    var latitude : String = ""
}
