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
    
    func issetOrder (id : Int, table: Int, state: Int) ->Bool{
        if (db.readOrder(table: table, state: state, product: id) != nil){
            return true
        }else{
            return false
        }
    }
      

      func addOrder(_ order: Order){

          db.insertOrder(order: order)
        db.readOrders()
          //orders.append(order)
          
      }
      
    func removeOrder(id : Int, table: Int, state: Int){
        //orders.remove(at: index)
        db.deleteOrder(table: table, state: state, product: id)
        
      }
      
      
    func SQLInsertOrder(order: Order){
        
          db.insertOrder(order: order)
         orders = db.readOrders()
          
      }
      
      
    func detectChanges (table: Int){
        let actualOrders = db.readOrdersByState_Table(table: table, state: 2)
        let newOrders = db.readOrdersByState_Table(table: table, state: 1)
        var changes: String = ""
        for a in actualOrders{
            for n in newOrders{
                if (a.id == n.id){
                    let dif:Int = n.quantity - a.quantity
                    if (dif > 0){
                        changes += "Añadir \(abs(dif)) \(n.name)"
                    }else if (dif < 0 ){
                        changes += "Quitar \(abs(dif)) \(n.name)"
                    }
                }
                
                if (a.id != n.id){
                    let dif:Int = n.quantity - a.quantity
                    if (dif > 0){
                        changes += "Añadir \(abs(dif)) \(n.name)"
                    }else if (dif < 0 ){
                        changes += "Quitar \(abs(dif)) \(n.name)"
                    }
                }
            }
        }
    }
    
    
    
    
    

}
