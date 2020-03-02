//
//  Order.swift
//  PatacoreSwift
//
//  Created by Johana on 3/2/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import Foundation

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
