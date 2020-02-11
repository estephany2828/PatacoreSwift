//
//  ProductsManager.swift
//  PatacoreSwift
//
//  Created by Johana on 2/10/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import Foundation
import UIKit

class ProductsManger{
    
    private lazy var products:[Product] = self.loadProducts()
    var productCount: Int{
        return products.count
    }
    func getProduct(at index: Int)->Product{
        return products[index]
    }
    private func loadProducts()->[Product]{
        return sampleProducts()
    }
    func addProduct(_ product: Product){
        products.append(product)
    }
    private func sampleProducts()->[Product]{
        return [
            Product(id:1, name: "pollito", price: "5000", description: "pollito en salsa de champinones"),
            Product(id:2, name: "pollito2", price: "6000", description: "pollito2 en salsa de champinones"),
              Product(id:3, name: "pollito3", price: "6000", description: "pollito2 en salsa de champinones"),         ]
        
    }
    
}
