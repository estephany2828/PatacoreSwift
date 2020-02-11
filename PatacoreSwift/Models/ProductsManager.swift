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
    
    //cuenta cuantos productos hay
    var productCount: Int{
        return products.count
    }
    //para obtener un producto con su posicion
    func getProduct(at index: Int)->Product{
        return products[index]
    }
    //actualiza un producto de acuerdo a la poscion recibe posicion y el array
    func updateProduct(at index: Int, with product : Product ){
        products[index] = product
                
    }
    //despleja los productos que estan en un array o bd
    private func loadProducts()->[Product]{
        return sampleProducts()
    }
    //agrega productos y loscoloca al final
    func addProduct(_ product: Product){
        products.append(product)
    }
    //elimina el producto dea cuerdo al parametro de posicion que le envian
    func removeProduct(at index : Int){
        products.remove(at: index)
    }
    //algunos productos de prueba utilizando array
    private func sampleProducts()->[Product]{
        return [
            Product(id:1, name: "pollito", price: "5000", description: "pollito en salsa de champinones"),
            Product(id:2, name: "pollito2", price: "6000", description: "pollito2 en salsa de champinones"),
              Product(id:3, name: "pollito3", price: "6000", description: "pollito2 en salsa de champinones"),         ]
        
    }
    
}
