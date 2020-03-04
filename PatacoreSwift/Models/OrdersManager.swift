//
//  OrdersMagner.swift
//  PatacoreSwift
//
//  Created by Telematica on 3/03/20.
//  Copyright © 2020 Johana. All rights reserved.
//

import Foundation
import UIKit

class OrdersManager {
    
    var db:DBHelper = DBHelper ()
    private lazy var orders: [Order] = db.readOrders ()
    
    var orderCount: Int{
          return orders.count
      }

      func getOrder(at index: Int)->Product{
          return orders[index]
      }
      
      func updateOrder(at index: Int, with order : Order ){
          
          orders[index] = order
                  
      }
  
      private func loadOrders()->[Order]{
          return db.readOrders()
      }
      

      func addOrder(_ order: Order){

          db.insertOrder(order: order)
          orders.append(order)
          
      }
      
    func removeOrder(index : Int, table: Int, state: Int){
          orders.remove(at: index)

          db.deleteProductByID(id: index)
      }
      
      
    func SQLInsertOrder(order: Order){
        
          db.insertOrder(order: order)
         orders = db.readOrders()
          
      }
      
      
    
    
    
    
    
    

}
