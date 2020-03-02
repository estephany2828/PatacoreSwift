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
    
    //private lazy var products:[Product] = self.loadProducts()
    private lazy var products:[Product] = db.readProducts()
    //llamamos la clase DBHelper donde esta la base de datos
    var db: DBHelper=DBHelper()
    //crear array products
    
    //var products:[Product] = []
    
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
    
    //agregamos productos a la base de datos
    func SQLInsertProduct(){
        db.insertProduct(product:Product(name: "Filet Mignon", price: 5000, description: "350gr de carne de res en salsa de champiñones, porción de arroz y ensalada",imag:"jjj"))        
        products = db.readProducts()
        
    }
    
    

    //algunos productos de prueba utilizando array
    private func sampleProducts()->[Product]{
        return [
            Product(id:1,name: "Filet Mignon", price: 5000, description: "350gr de carne de res en salsa de champiñones, porción de arroz y ensalada",imag:"jjj"),
            Product(id:2,name: "pollito2", price: 6000, description: "pollito2 en salsa de champinones",imag:"jjj"),
            Product(id:3,name: "pollito3", price: 6000, description: "pollito2 en salsa de champinones",imag:"jjj"),
        Product(id:4,name: "Cazuela de pescado", price: 16000, description: "Porción de pescado, aguacate, arroz, ensalada, patacones y limonada natural",imag:"jjj"),
        Product(id:5,name: "pollito4", price: 6000, description: "pollito2 en salsa de champinones",imag:"jjj"),
        Product(id:5,name: "pollito5", price: 6000, description: "pollito2 en salsa de champinones",imag:"jjj"),
        Product(id:5,name: "pollito6", price: 6000, description: "pollito2 en salsa de champinones",imag:"jjj"),
        Product(id:5,name: "pollito7", price: 6000, description: "pollito2 en salsa de champinones",imag:"jjj"),
        Product(id:5,name: "pollito8", price: 6000, description: "pollito2 en salsa de champinones",imag:"jjj")]
        
    }
    
}
