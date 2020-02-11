//
//  Product.swift
//  PatacoreSwift
//
//  Created by Johana on 2/10/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import Foundation
import UIKit

struct Product {
    static let defaultImg = UIImage(named: "panadero.jpg")!
    var id:Int
    var name:String
    var price:String
    var description:String
     
    var img:UIImage{
        get {
            return  image ?? Product.defaultImg
        }
        set {
            image = newValue
        }
    }
    private var image : UIImage? = nil
    

init(id:Int,name:String,price:String,description:String,img:UIImage?=nil){
    self.id = id
    self.name = name
    self.price = price
    self.description = description
    self.image = img
    
}
}
