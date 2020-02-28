//
//  Product.swift
//  PatacoreSwift
//
//  Created by Johana on 2/10/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import Foundation
import UIKit

class Product {
    static let defaultImg = UIImage(named: "panadero.jpg")!
    var id:Int
    var name:String
    var price:Int
    var description:String
    var imag:String
     
    var img:UIImage{
        get {
            return  image ?? Product.defaultImg
        }
        set {
            image = newValue
        }
    }
    private var image : UIImage? = nil
    

    init(id:Int?=nil, name:String,price:Int,description:String,imag:String,img:UIImage? = nil){
        self.id=id ?? -1
    self.name = name
    self.price = price
    self.description = description
    self.imag = imag
    self.image = img
    
}
}

class Order:Product{
    var table:Int
    var state:Int
    var annotation:String
    var quantity:Int
    var date:String
    var hour:String
    
    
    init(product:Product, table:Int, state: Int, annotation:String, quantity:Int, date:String, hour:String){
        self.table = table
        self.state = state
        self.annotation = annotation
        self.quantity = quantity
        self.date = date
        self.hour = hour
        
        super.init(id:product.id, name: product.name, price: product.price, description: product.description, imag: product.imag)
    }
    
}
